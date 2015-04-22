#include "FileUnit.h"
using namespace std;

FileUnit* FileUnit::create(std::string filename)
{
	return new FileUnit(filename);
}

FileUnit::FileUnit(std::string filename)
{
	m_filename = "D:/" + filename; 
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
	m_filename = "/mnt/sdcard/" + filename; 
#endif
	m_pfileeditsys = NULL;
	m_pfileeditsys = fileeditsys::create(m_filename);
	if (m_pfileeditsys)
	{
		if (m_pfileeditsys->filedataisempty())
		{
			m_pfileeditsys->addfiledata(NULL, "index", "folder");
			m_pfileeditsys->addfiledata(NULL, "mate", "folder");
		}
	}
	m_curpath.push_back("index");
	m_psqlite3 = NULL;
	//int res = sqlite3_open(m_filename.c_str(), &m_psqlite3);
	//if (res != SQLITE_OK)
	//{
	//	m_psqlite3 = NULL;
	//}
	//else
	//{
	//	char* tmp = NULL;
	//	res = sqlite3_exec(m_psqlite3, "create table bookroot(bookurl varchar(100), bookname varchar(50))", 0, 0, &tmp);
	//	if (res != SQLITE_OK)
	//	{
	//		sqlite3_free(tmp);
	//	}
	//}
}

FileUnit::~FileUnit()
{
	if (m_pfileeditsys)
	{
		m_pfileeditsys->destroy();
	}
	if (m_psqlite3)
	{
		sqlite3_close(m_psqlite3);
	}
}

void FileUnit::runcommand(std::string cmd)
{

}

bool FileUnit::createdir(std::string dirname)
{
	//if (m_pfileeditsys)
	//{
	//	treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
	//	if (p && p->_cell.content == "folder")
	//	{
	//		vector<string> _v(m_curpath.begin(), m_curpath.end());
	//		_v.push_back(dirname);
	//		treecellpoint* pp = m_pfileeditsys->findfiledata(_v);
	//		if (pp)
	//		{
	//			return false;
	//		}
	//		m_pfileeditsys->addfiledata(p, dirname, "folder");
	//		return true;
	//	}
	//}
	//return false;

	if (m_pfileeditsys)
	{
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(m_curpath, p);
		if (res && p._cell.content == "folder")
		{
			vector<string> _v(m_curpath.begin(), m_curpath.end());
			_v.push_back(dirname);
			treecellpoint pp;
			bool res1 = m_pfileeditsys->findfiledata(_v, pp);
			if (res1)
			{
				return false;
			}
			m_pfileeditsys->addfiledata(m_curpath, dirname, "folder", "");
			return true;
		}
	}
	return false;
}

bool FileUnit::createfile(std::string filename, std::string filecontent, std::string flag)
{
	//if (m_pfileeditsys)
	//{
	//	treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
	//	if (p && p->_cell.content == "folder")
	//	{
	//		vector<string> _v(m_curpath.begin(), m_curpath.end());
	//		_v.push_back(filename);
	//		treecellpoint* pp = m_pfileeditsys->findfiledata(_v);
	//		if (pp)
	//		{
	//			return false;
	//		}
	//		m_pfileeditsys->addfiledata(p, filename, filecontent);
	//		return true;
	//	}
	//}
	//return false;

	if (m_pfileeditsys)
	{
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(m_curpath, p);
		if (res && p._cell.content == "folder")
		{
			vector<string> _v(m_curpath.begin(), m_curpath.end());
			_v.push_back(filename);
			treecellpoint pp;
			bool res1 = m_pfileeditsys->findfiledata(_v, pp);
			if (res1)
			{
				return false;
			}
			m_pfileeditsys->addfiledata(m_curpath, filename, filecontent, flag);
			return true;
		}
	}
	return false;
}

bool FileUnit::createfile1(std::string filename, std::string filecontent, std::string flag)
{
	//if (m_pfileeditsys)
	//{
	//	treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
	//	if (p && p->_cell.content == "folder")
	//	{
	//		vector<string> _v(m_curpath.begin(), m_curpath.end());
	//		_v.push_back(filename);
	//		treecellpoint* pp = m_pfileeditsys->findfiledata(_v);
	//		if (pp)
	//		{
	//			return false;
	//		}
	//		m_pfileeditsys->addfiledata(p, filename, filecontent);
	//		return true;
	//	}
	//}
	//return false;

	if (m_pfileeditsys)
	{
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(m_curpath, p);
		if (res)
		{
			vector<string> _v(m_curpath.begin(), m_curpath.end());
			_v.push_back(filename);
			treecellpoint pp;
			bool res1 = m_pfileeditsys->findfiledata(_v, pp);
			if (res1)
			{
				return false;
			}
			m_pfileeditsys->addfiledata(m_curpath, filename, filecontent, flag);
			return true;
		}
	}
	return false;
}

bool FileUnit::openpath(std::string dirname)
{
	if (m_pfileeditsys)
	{
		vector<string> _v(m_curpath.begin(), m_curpath.end());
		_v.push_back(dirname);
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(_v, p);
		if (res)
		{
			m_curpath.push_back(dirname);
			return true;
		}
	}
	return false;
}

bool FileUnit::opendir(std::string dirname)
{
	//if (m_pfileeditsys)
	//{
	//	vector<string> _v(m_curpath.begin(), m_curpath.end());
	//	_v.push_back(dirname);
	//	treecellpoint* p = m_pfileeditsys->findfiledata(_v);
	//	if (p && p->_cell.content == "folder")
	//	{
	//		m_curpath.push_back(dirname);
	//		return true;
	//	}
	//}
	//return false;

	if (m_pfileeditsys)
	{
		vector<string> _v(m_curpath.begin(), m_curpath.end());
		_v.push_back(dirname);
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(_v, p);
		if (res && p._cell.content == "folder")
		{
			m_curpath.push_back(dirname);
			return true;
		}
	}
	return false;
}

bool FileUnit::openfile(std::string filename)
{
	//if (m_pfileeditsys)
	//{
	//	vector<string> _v(m_curpath);
	//	_v.push_back(filename);
	//	treecellpoint* p = m_pfileeditsys->findfiledata(_v);
	//	if (p && p->_cell.content != "folder")
	//	{
	//		m_curpath.push_back(filename);
	//		return true;
	//	}
	//}
	//return false;

	if (m_pfileeditsys)
	{
		vector<string> _v(m_curpath.begin(), m_curpath.end());
		_v.push_back(filename);
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(_v, p);
		if (res && p._cell.content != "folder")
		{
			m_curpath.push_back(filename);
			return true;
		}
	}
	return false;
}

std::string FileUnit::getcurfile()
{
	//if (m_pfileeditsys)
	//{
	//	treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
	//	if (p && p->_cell.content != "folder")
	//	{
	//		return p->_cell.content;
	//	}
	//}
	//return "";

	if (m_pfileeditsys)
	{
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(m_curpath, p);
		if (res && p._cell.content != "folder")
		{
			return p._cell.content;
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
	//m_celllist.clear();
	//if (m_pfileeditsys)
	//{
	//	treecellpoint* p = m_pfileeditsys->findfiledata(m_curpath);
	//	if (p && m_pfileeditsys->readfilechilddata(p))
	//	{
	//		p = p->_child;
	//		if (p && m_pfileeditsys->readfileallbrotherdata(p))
	//		{
	//			treecellpoint* pp = p;
	//			while (pp)
	//			{
	//				celldef* a = celldef::create();
	//				a->m_title = pp->_cell.title;
	//				if (pp->_cell.content == "folder")
	//					a->m_content = pp->_cell.content;
	//				m_celllist.pushBack(a);
	//				pp = pp->_brother;
	//			}
	//		}
	//	}
	//}
	//return m_celllist;

	m_celllist.clear();
	if (m_pfileeditsys)
	{
		vector<treecell> vec = m_pfileeditsys->getallchild(m_curpath);
		for (auto &c : vec)
		{
			celldef* a = celldef::create();
			a->m_title = c.flag;
			//if (c.content == "folder")
			a->m_path = c.title;
			a->m_content = c.content;
			m_celllist.pushBack(a);
		}
	}
	return m_celllist;
}

std::vector<std::string>& FileUnit::getfullpath()
{
	return m_curpath;
}

Vector<celldef*>& FileUnit::getbooklist()
{
	gotorootdir();
	return getfilelist();
}

bool FileUnit::createnewbook(std::string name, std::string url)
{
	gotorootdir();
	return createfile1(url, "bookname", name);
}

bool FileUnit::openbook(std::string name, std::string url)
{
	gotorootdir();
	return openpath(url);
}

Vector<celldef*>& FileUnit::getbooktitlelist()
{
	if ((m_curpath.size() != 2))
	{
		m_celllist.clear();
		return m_celllist;
	}
	return getfilelist();
}

bool FileUnit::addbooktitle(std::string name, std::string url)
{
	if (m_curpath.size() < 2)
	{
		return false;
	}
	vector<string> tmpvec(m_curpath.begin(), m_curpath.end());
	m_curpath.clear();
	m_curpath.push_back(tmpvec[0]);
	m_curpath.push_back(tmpvec[1]);
	bool res = createfile1(url, "booktitle", name);
	m_curpath = tmpvec;
	return res;
}

bool FileUnit::openbooktitle(std::string name, std::string url)
{
	if (m_curpath.size() < 2)
	{
		return false;
	}
	vector<string> tmpvec(m_curpath.begin(), m_curpath.end());
	m_curpath.clear();
	m_curpath.push_back(tmpvec[0]);
	m_curpath.push_back(tmpvec[1]);
	return openpath(url);
}

bool FileUnit::addbooktitlecontent(std::string title, std::string content, std::string url)
{
	return openbooktitle(title, url) && createfile1("txt", content, title);
}

bool FileUnit::openbooktitlecontent(std::string name, std::string url)
{
	return openbooktitle(name, url) && openfile("txt");
}

std::string FileUnit::getbooktitlecontent()
{
	return getcurfile();
}

bool FileUnit::onpageback()
{
	gotorootdir();
	return true;
}

std::string FileUnit::getmybookname()
{
	vector<string> tmpvec(m_curpath.begin(), m_curpath.end());
	m_curpath.clear();
	m_curpath.push_back(tmpvec[0]);
	m_curpath.push_back(tmpvec[1]);
	if (m_pfileeditsys)
	{
		treecellpoint p;
		bool res = m_pfileeditsys->findfiledata(m_curpath, p);
		if (res)
		{
			m_curpath = tmpvec;
			return p._cell.title;
		}
	}
	m_curpath = tmpvec;
	return "";
}

/*
Vector<celldef*>& FileUnit::getbooklist()
{
	return m_celllist;
}

bool FileUnit::createnewbook(std::string name, std::string url)
{
	return true;
}

bool FileUnit::openbook(std::string name, std::string url)
{
	return true;
}

Vector<celldef*>& FileUnit::getbooktitlelist(std::string name, std::string url)
{
	return m_celllist;
}

bool FileUnit::addbooktitle(std::string name, std::string url)
{
	return true;
}

bool FileUnit::openbooktitle(std::string name, std::string url)
{
	return true;
}

bool FileUnit::addbooktitlecontent(std::string title, std::string content, std::string url)
{
	return true;
}

bool FileUnit::openbooktitlecontent(std::string name, std::string url)
{
	return true;
}

std::string FileUnit::getbooktitlecontent()
{
	return "";
}

bool FileUnit::onpageback()
{
	return true;
}
*/