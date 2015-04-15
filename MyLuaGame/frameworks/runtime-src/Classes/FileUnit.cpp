#include "FileUnit.h"
using namespace std;

FileUnit* FileUnit::create(std::string filename)
{
	return new FileUnit(filename);
}

FileUnit::FileUnit(std::string filename)
{
	m_filename = "D:/" + filename; 
	m_pfileeditsys = fileeditsys::create(m_filename);
	if (m_pfileeditsys)
	{
		if (m_pfileeditsys->filedataisempty())
		{
			m_pfileeditsys->addfiledata(NULL, "index", "folder");
		}
	}
	m_curpath.push_back("index");
}

FileUnit::~FileUnit()
{
	if (m_pfileeditsys)
	{
		m_pfileeditsys->destroy();
	}
}

void FileUnit::runcommand(std::string cmd)
{

}

bool FileUnit::createdir(std::string dirname)
{
	if (m_pfileeditsys)
	{
		treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
		if (p && p->_cell.content == "folder")
		{
			vector<string> _v(m_curpath.begin(), m_curpath.end());
			_v.push_back(dirname);
			treecellpoint* pp = m_pfileeditsys->findfiledata(_v);
			if (pp)
			{
				return false;
			}
			m_pfileeditsys->addfiledata(p, dirname, "folder");
			return true;
		}
	}
	return false;

	//if (m_pfileeditsys)
	//{
	//	treecellpoint p;
	//	bool res = m_pfileeditsys->findfiledata(m_curpath, p);
	//	if (res && p._cell.content == "folder")
	//	{
	//		vector<string> _v(m_curpath.begin(), m_curpath.end());
	//		_v.push_back(dirname);
	//		treecellpoint pp;
	//		bool res1 = m_pfileeditsys->findfiledata(_v, pp);
	//		if (res1)
	//		{
	//			return false;
	//		}
	//		m_pfileeditsys->addfiledata(p, dirname, "folder");
	//		return true;
	//	}
	//}
	//return false;
}

bool FileUnit::createfile(std::string filename, std::string filecontent)
{
	if (m_pfileeditsys)
	{
		treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
		if (p && p->_cell.content == "folder")
		{
			vector<string> _v(m_curpath.begin(), m_curpath.end());
			_v.push_back(filename);
			treecellpoint* pp = m_pfileeditsys->findfiledata(_v);
			if (pp)
			{
				return false;
			}
			m_pfileeditsys->addfiledata(p, filename, filecontent);
			return true;
		}
	}
	return false;
}

bool FileUnit::opendir(std::string dirname)
{
	if (m_pfileeditsys)
	{
		vector<string> _v(m_curpath.begin(), m_curpath.end());
		_v.push_back(dirname);
		treecellpoint* p = m_pfileeditsys->findfiledata(_v);
		if (p && p->_cell.content == "folder")
		{
			m_curpath.push_back(dirname);
			return true;
		}
	}
	return false;
}

bool FileUnit::openfile(std::string filename)
{
	if (m_pfileeditsys)
	{
		vector<string> _v(m_curpath);
		_v.push_back(filename);
		treecellpoint* p = m_pfileeditsys->findfiledata(_v);
		if (p && p->_cell.content != "folder")
		{
			m_curpath.push_back(filename);
			return true;
		}
	}
	return false;
}

std::string FileUnit::getcurfile()
{
	if (m_pfileeditsys)
	{
		treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
		if (p && p->_cell.content != "folder")
		{
			return p->_cell.content;
		}
	}
	return "";
}

bool FileUnit::gotoupdir()
{
	if (m_curpath.size() > 1)
	{
		m_curpath.pop_back();
		return true;
	}
	return false;
}

void FileUnit::gotorootdir()
{
	while (m_curpath.size() > 1)
	{
		m_curpath.pop_back();
	}
}


Vector<celldef*>& FileUnit::getfilelist()
{
	m_celllist.clear();
	if (m_pfileeditsys)
	{
		treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
		if (p && m_pfileeditsys->readfilechilddata(p))
		{
			p = p->_child;
			if (p && m_pfileeditsys->readfileallbrotherdata(p))
			{
				treecellpoint* pp = p;
				while (pp)
				{
					celldef* a = celldef::create();
					a->m_title = pp->_cell.title;
					if (pp->_cell.content == "folder")
						a->m_content = pp->_cell.content;
					m_celllist.pushBack(a);
					pp = pp->_brother;
				}
			}
		}
	}
	return m_celllist;
}

std::vector<std::string>& FileUnit::getfullpath()
{
	return m_curpath;
}