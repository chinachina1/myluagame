#include "fileeditsys.h"
#include "map"

map<string, fileeditsys*> g_filepointlist;
fileeditsys* fileeditsys::create(string filename)
{
	if (g_filepointlist.find(filename) == g_filepointlist.end())
	{
		fileeditsys* p = new fileeditsys();
		p->setFileName(filename);
		if (! p->openFile())
		{
			delete p;
			return NULL;
		}
		g_filepointlist[filename] = p;
		return p;
	}
	else
	{
		fileeditsys* p = g_filepointlist[filename];
		p->retain();
		return p;
	}
}

fileeditsys::fileeditsys()
{
	m_filehandle = NULL;
	m_proot = NULL;
	vector<string> _t;
	m_fastindex[_t] = 0;
}

fileeditsys::~fileeditsys()
{
	closeFile();
	stack<treecellpoint*> _tmp;
	//if (m_proot)
	//{
	//	delete m_proot;
	//}
	if (m_proot)
	{
		_tmp.push(m_proot);
	}
	while (!_tmp.empty())
	{
		treecellpoint* p = _tmp.top();
		if (p->_brother || p->_child)
		{
			if (p->_brother)
			{
				_tmp.push(p->_brother);
				p->_brother = NULL;
			}
			if (p->_child)
			{
				_tmp.push(p->_child);
				p->_child = NULL;
			}
		}
		else
		{
			_tmp.pop();
			delete p;
		}
	}
}

void fileeditsys::destroy()
{
	if (getReferenceCount() == 1)
	{
		g_filepointlist.erase(g_filepointlist.find(m_filename));
	}
	this->release();
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
	m_filehandle = fopen(m_filename.c_str(), "rb");
	if (!m_filehandle)
	{
		m_filehandle = fopen(m_filename.c_str(), "w");
		if (m_filehandle)
		{
			fclose(m_filehandle);
		}
		m_filehandle = fopen(m_filename.c_str(), "rb");
	}
	return !!m_filehandle;
}

bool fileeditsys::switchwrite()
{
	closeFile();
	m_iotype = 1;
	m_filehandle = fopen(m_filename.c_str(), "rb+");
	if (!m_filehandle)
	{
		m_filehandle = fopen(m_filename.c_str(), "w");
		if (m_filehandle)
		{
			fclose(m_filehandle);
		}
		m_filehandle = fopen(m_filename.c_str(), "rb+");
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
	fpos tmp = 0;
	int len = fread(&tmp, sizeof(tmp), 1, m_filehandle);
	f = tmp;
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
	int len = 0;
	while ((len = fread(&a, 1, 1, m_filehandle)) && a)
	{
		m_readtempbuff.push_back(a);
	}
	if (len == 0)
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
	if (readpos(t.beginpos) && readpos(t.brotherpos) && readpos(t.childpos) && readstring(t.title) && readstring(t.content) && readstring(t.flag))
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

bool fileeditsys::findfiledata(vector<string> cmd, treecellpoint& infile)
{
	if (cmd.size() == 0)
	{
		treecell cc;
		if (setfilepos(0) && readfiletreecelldata(cc))
		{
			infile._cell = cc;
		}
		return true;
	}
	vector<string> cashcmd = cmd;
	fpos bp = 0;
	getcashpath(cashcmd, bp);
	if (cashcmd == cmd)
	{
		if (setfilepos(bp)&& readfiletreecelldata(infile._cell))
		{
			return true;
		}
		return false;
	}
	vector<string> lastcmd(cmd.begin() + (int)cashcmd.size(), cmd.end());
	for (int i = 0; i < (int)lastcmd.size(); i++)
	{
		string str = lastcmd[i];
		if (setfilepos(bp)&& readfiletreecelldata(infile._cell))
		{
			if (infile._cell.title == str)
			{
				//
				bp = infile._cell.childpos;
			}
			else
			{
				fpos nextpos = infile._cell.brotherpos;
				while (nextpos)
				{
					if (setfilepos(nextpos) && readfiletreecelldata(infile._cell))
					{
						if (infile._cell.title == str)
						{
							break;
						}
						else
						{
							nextpos = infile._cell.brotherpos;
						}
					}
					else
					{
						return false;
					}
				}
				if (infile._cell.title == str)
				{
					bp = infile._cell.childpos;
				}
				else
				{
					return false;
				}
			}
		}
		else
		{
			return false;
		}
	}
	addcashpath(cmd, infile._cell.beginpos);
	return true;
}

vector<treecell> fileeditsys::getallbrother(vector<string> cmd)
{
	vector<treecell> ll;
	treecellpoint pc;
	if (findfiledata(cmd, pc))
	{
		ll.push_back(pc._cell);
		fpos tmppos = pc._cell.brotherpos;
		while (tmppos)
		{
			treecell cc;
			if (setfilepos(tmppos) && readfiletreecelldata(cc))
			{
				ll.push_back(cc);
				tmppos = cc.brotherpos;
			}
			else
			{
				//ll.clear();
				break;
			}
		}
	}
	return ll;
}

bool fileeditsys::getfirstchild(vector<string> cmd, treecell&child)
{
	if (cmd.size() != 0)
	{
		treecellpoint pc;
		if (findfiledata(cmd, pc))
		{
			if (pc._cell.childpos > 0)
			{
				if (setfilepos(pc._cell.childpos) && readfiletreecelldata(child))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}
	else
	{
		child = readgendata()->_cell;
		return true;
	}
	return true;
}

bool fileeditsys::addfiledata(vector<string> cmd, string title, string content, string flag)
{
	treecellpoint parent;
	if (findfiledata(cmd, parent))
	{
		treecellpoint me;
		setfileposend();
		fpos bb = ftell(m_filehandle);
		me._cell.beginpos = bb;
		me._cell.brotherpos = 0;
		me._cell.childpos = 0;
		me._cell.title = title;
		me._cell.content = content;
		me._cell.flag = flag;
		bool res = addfiledata(me._cell);
		if (!res)
		{
			return false;
		}
		vector<string> tmpv(cmd.begin(), cmd.end());
		tmpv.push_back(title);
		addcashpath(tmpv, bb);
		treecell firstbrother;
		if (getfirstchild(cmd, firstbrother))
		{
			treecell tmpbrother = firstbrother;
			fpos fp = tmpbrother.brotherpos;
			while (fp)
			{
				if (setfilepos(fp) && readfiletreecelldata(tmpbrother))
				{
					fp = tmpbrother.brotherpos;
				}
				else
				{
					return false;
				}
			}
			tmpbrother.brotherpos = me._cell.beginpos;
			editfiledata(tmpbrother);
		}
		else
		{
			parent._cell.childpos = me._cell.beginpos;
			editfiledata(parent._cell);
		}
	}
	else
	{
		return false;
	}
	return true;
}

vector<treecell> fileeditsys::getallchild(vector<string> cmd)
{
	vector<treecell> ll;
	treecell firstchild;
	if (getfirstchild(cmd, firstchild))
	{
		vector<string> tmpcmd(cmd.begin(), cmd.end());
		tmpcmd.push_back(firstchild.title);
		ll = getallbrother(tmpcmd);
	}
	return ll;
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
	if (writepos(tt.beginpos) && writepos(tt.brotherpos) && writepos(tt.childpos) && writestring(tt.title) && writestring(tt.content) && writestring(tt.flag))
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

void fileeditsys::addcashpath(vector<string> cmd, fpos fp)
{
	m_fastindex[cmd] = fp;
}

bool fileeditsys::getcashpath(vector<string> &inorout, fpos &fp)
{
	vector<string> cmd(inorout.begin(), inorout.end());
	while (! cmd.empty())
	{
		auto it = m_fastindex.find(cmd);
		if (it != m_fastindex.end())
		{
			//inorout = cmd;
			//fp = m_fastindex[cmd];
			break;
		}
		cmd.pop_back();
	}
	if (!cmd.empty() && cmd != inorout)
	{
		inorout = cmd;
		fp = m_fastindex[cmd];
		treecell cell;
		if (setfilepos(fp)&& readfiletreecelldata(cell))
		{
			fp = cell.childpos;
		}
		else
		{
			inorout.clear();
			fp = 0;
		}
	}
	else
	{
		inorout = cmd;
		fp = m_fastindex[cmd];
	}
	return true;
}