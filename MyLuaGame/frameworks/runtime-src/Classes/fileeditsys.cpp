#include "fileeditsys.h"

fileeditsys* fileeditsys::create(string filename)
{
	fileeditsys* p = new fileeditsys();
	p->setFileName(filename);
	if (! p->openFile())
	{
		delete p;
		return NULL;
	}
	return p;
}

fileeditsys::fileeditsys()
{
	m_filehandle = NULL;
	m_proot = NULL;
}

fileeditsys::~fileeditsys()
{
	closeFile();
	if (m_proot)
	{
		delete m_proot;
	}
}

void fileeditsys::setFileName(string filename)
{
	m_filename = filename;
}

bool fileeditsys::openFile()
{
	return switchread();
}

bool fileeditsys::saveFile()
{
	if (m_filehandle)
	{
		fflush(m_filehandle);
	}
	return true;
}

bool fileeditsys::closeFile()
{
	if (m_filehandle)
	{
		fclose(m_filehandle);
		m_filehandle = NULL;
	}
	return true;
}

bool fileeditsys::switchread()
{
	return switchwrite();
	closeFile();
	m_iotype = 0;
	m_filehandle = fopen(m_filename.c_str(), "r");
	if (!m_filehandle)
	{
		m_filehandle = fopen(m_filename.c_str(), "w");
		if (m_filehandle)
		{
			fclose(m_filehandle);
		}
		m_filehandle = fopen(m_filename.c_str(), "r");
	}
	return !!m_filehandle;
}

bool fileeditsys::switchwrite()
{
	closeFile();
	m_iotype = 1;
	m_filehandle = fopen(m_filename.c_str(), "r+");
	if (!m_filehandle)
	{
		m_filehandle = fopen(m_filename.c_str(), "w");
		if (m_filehandle)
		{
			fclose(m_filehandle);
		}
		m_filehandle = fopen(m_filename.c_str(), "r+");
	}
	return !!m_filehandle;
}

bool fileeditsys::setfilepos(fpos pos)
{
	int res = fseek(m_filehandle, pos, SEEK_SET);
	return res == 0;
}

bool fileeditsys::setfileposend()
{
	int res = fseek(m_filehandle, 0, SEEK_END);
	return res == 0;
}

bool fileeditsys::readpos(fpos& f)
{
	int len = fread(&f, sizeof(f), 1, m_filehandle);
	return len == 1;
}

bool fileeditsys::writepos(fpos p)
{
	int len = fwrite(&p, sizeof(p), 1, m_filehandle);
	return len == 1;
}

bool fileeditsys::readstring(string& s)
{
	m_readtempbuff.clear();
	char a = 0;
	while (fread(&a, 1, 1, m_filehandle) && a)
	{
		m_readtempbuff.push_back(a);
	}
	if (a != 0 || m_readtempbuff.size() == 0)
	{
		return false;
	}
	m_readtempbuff.push_back(a);
	s = (char*)(&m_readtempbuff[0]);
	return true;
}

bool fileeditsys::writestring(string s)
{
	int len = fwrite(s.c_str(), s.size() + 1, 1, m_filehandle);
	return len == 1;
}

bool fileeditsys::readfiletreecelldata(treecell &t)
{
	if (readpos(t.beginpos) && readpos(t.brotherpos) && readpos(t.childpos) && readstring(t.title) && readstring(t.content))
	{
		return true;
	}
	return false;
}

bool fileeditsys::filedataisempty()
{
	readgendata();
	if (m_proot->_cell.title == "" && m_proot->_child == 0)
	{
		return true;
	}
	return false;
}

treecellpoint* fileeditsys::readgendata()
{
	if (m_proot)
		return m_proot;
	treecellpoint* p = new treecellpoint();
	m_proot = p;
	setfilepos(0);
	if (! readfiletreecelldata(p->_cell))
	{
		return p;
	}
	auto readfun = [&](treecellpoint* input)->bool {
		return true;
	};
	return p;
}

bool fileeditsys::readfilebrotherdata(treecellpoint* p)
{
	if (p->_cell.brotherpos > 0 && p->_brother == NULL)
	{
		treecellpoint* pp = new treecellpoint();
		setfilepos(p->_cell.brotherpos);
		if (readfiletreecelldata(pp->_cell))
		{
			p->_brother = pp;
		}
		else
		{
			delete pp;
			return false;
		}
	}
	return true;
}

bool fileeditsys::readfileallbrotherdata(treecellpoint* p)
{
	treecellpoint* pp = p;
	if (pp->_brother)
	{
		return true;
	}
	while (pp && readfilebrotherdata(pp) && pp->_brother)
	{
		pp = pp->_brother;
	}
	return true;
}

bool fileeditsys::readfilechilddata(treecellpoint* p)
{
	if (p->_cell.childpos > 0 && p->_child == NULL)
	{
		treecellpoint* pp = new treecellpoint();
		setfilepos(p->_cell.childpos);
		if (readfiletreecelldata(pp->_cell))
		{
			p->_child = pp;
		}
		else
		{
			delete pp;
			return false;
		}
	}
	return true;
}

treecellpoint* fileeditsys::findfiledata(vector<string> cmd)
{
	if (cmd.size() == 0)
		return NULL;
	treecellpoint* pp = readgendata();
	if (cmd.size() == 1 && pp->_cell.title == cmd[0])
		return pp;
	for (int i = 0; i < (int)cmd.size(); i++)
	{
		string str = cmd[i];
		if (pp == NULL)
		{
			break;
		}
		readfileallbrotherdata(pp);
		treecellpoint* p1 = pp;
		while (p1)
		{
			if (p1->_cell.title == str)
			{
				pp = p1;
				break;
			}
			p1 = p1->_brother;
		}
		if (pp->_cell.title == str)
		{
			if (i < ((int)cmd.size() - 1))
			{
				readfilechilddata(pp);
				pp = pp->_child;
			}
		}
		else
		{
			return NULL;
		}
	}
	if (pp && pp->_cell.title == cmd.back())
	{
		return pp;
	}
	return NULL;
}

bool fileeditsys::addfiledata(treecellpoint* parent, string title, string content)
{
	treecellpoint* nowcell = NULL;
	if (parent == NULL && filedataisempty())
	{
		nowcell = readgendata();
	}
	else
	{
		nowcell = new treecellpoint;
	}
	{
		setfileposend();
		fpos bb = ftell(m_filehandle);
		nowcell->_cell.beginpos = bb;
		nowcell->_cell.brotherpos = 0;
		nowcell->_cell.childpos = 0;
		nowcell->_cell.title = title;
		nowcell->_cell.content = content;
		bool res = addfiledata(nowcell->_cell);
		if (!res)
		{
			delete nowcell;
			return false;
		}
	}
	treecellpoint* childcell = NULL;
	if (parent == NULL)
	{
		childcell = readgendata();
	}
	else
	{
		readfilechilddata(parent);
		childcell = parent->_child;
	}
	if (childcell)
	{
		readfileallbrotherdata(childcell);
		while (childcell->_brother)
		{
			childcell = childcell->_brother;
		}
	}
	if (childcell && childcell != nowcell)
	{
		childcell->_brother = nowcell;
		childcell->_cell.brotherpos = nowcell->_cell.beginpos;
		editfiledata(childcell->_cell);
	}
	if (parent && childcell == NULL)
	{
		parent->_child = nowcell;
		parent->_cell.childpos = nowcell->_cell.beginpos;
		editfiledata(parent->_cell);
	}
	return true;
}

bool fileeditsys::addfiledata(treecell& tt)
{
	setfilepos(tt.beginpos);
	if (writepos(tt.beginpos) && writepos(tt.brotherpos) && writepos(tt.childpos) && writestring(tt.title) && writestring(tt.content))
	{
		saveFile();
		return true;
	}
	return false;
}

bool fileeditsys::editfiledata(treecell& tt)
{
	return addfiledata(tt);
}