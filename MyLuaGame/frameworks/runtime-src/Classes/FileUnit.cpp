#include "FileUnit.h"
using namespace std;

FileUnit::FileUnit(std::string filename)
{
	m_filename = "D:/" + filename; 
	m_pfileeditsys = fileeditsys::create(m_filename);
	if (m_pfileeditsys)
	{
		if (m_pfileeditsys->filedataisempty())
		{
			m_pfileeditsys->addfiledata(NULL, "index", "");
		}
	}
}

FileUnit::~FileUnit()
{
	if (m_pfileeditsys)
	{
		delete m_pfileeditsys;
	}
}

bool FileUnit::isfileexit()
{
	return true;
}

void FileUnit::addrow(std::string row, std::string url, std::string content)
{
	celldef* cell = new celldef;
	cell->m_rowname = row;
	cell->m_url = url;
	cell->m_begin = 0;
	cell->m_size = 0;
	cell->m_content = content;
	cell->autorelease();
	m_celllist.pushBack(cell);
}

void FileUnit::clear()
{
	m_celllist.clear();
}

bool FileUnit::isrowexist(std::string row)
{
	return false;
}

std::string FileUnit::getrowcontent(std::string row)
{
	return "";
}

void FileUnit::setrow(std::string row, std::string content)
{
}

void FileUnit::loaddata(std::vector<char> input)
{
	unsigned long len = 0;
	auto getstring = [&](){
		std::string str = (char*)(&(input[len]));
		len = len + str.size() + 1;
		return str;
	};
	auto getunlong = [&](){
		unionlen.a = input[len + 0];
		unionlen.b = input[len + 1];
		unionlen.c = input[len + 2];
		unionlen.d = input[len + 3];
		len = len + 4;
		return unionlen.len;
	};
	m_title = getstring();
	m_baseurl = getstring();
	unsigned long cellsize = getunlong();
	//m_celllist.resize(cellsize);
	//for (auto &cell : m_celllist)
	m_celllist.clear();
	for (unsigned long i = 0; i < cellsize; i++)
	{
		celldef* cell = new celldef;
		cell->m_rowname = getstring();
		cell->m_url = getstring();
		cell->m_begin = getunlong();
		cell->m_size = getunlong();
		cell->m_content = getstring();
		cell->autorelease();
		m_celllist.pushBack(cell);
	}
}

void FileUnit::savedata()
{
	::remove(m_filename.c_str());
	FILE *file = fopen(m_filename.c_str(), "wb");
	if (! file)
	{
		return;
	}
	auto putstring =[&](std::string str) {
		fwrite(str.c_str(), sizeof(char), str.size(), file);
		char a = '\0';
		fwrite(&a, 1, 1, file);
	};
	auto putunlong = [&](unsigned long num) {
		unionlen.len = num;
		fwrite(&(unionlen.a), 1, 1, file);
		fwrite(&(unionlen.b), 1, 1, file);
		fwrite(&(unionlen.c), 1, 1, file);
		fwrite(&(unionlen.d), 1, 1, file);
	};
	putstring(m_title);
	putstring(m_baseurl);
	unsigned long veclen = m_celllist.size();
	putunlong(veclen);
	for (unsigned long i = 0; i < veclen; i++)
	{
		auto cell = m_celllist.at(i);
		putstring(cell->m_rowname);
		putstring(cell->m_url);
		putunlong(cell->m_begin);
		putunlong(cell->m_size);
		putstring(cell->m_content);
	}
	fclose(file);
}

void FileUnit::settestdata()
{
	m_baseurl = "www.baidu.com";
	m_title = "123";
	//m_celllist.resize(10);
	//m_celllist.clear();
	for (unsigned long i = 0; i < 10; i++)
	{
		celldef* cell = new celldef;
		cell->m_rowname = "t";
		cell->m_url = "123";
		cell->m_begin = 1;
		cell->m_size = 2;
		cell->m_content = "eeee";
		cell->autorelease();
		m_celllist.pushBack(cell);
	}
}

std::string FileUnit::getbaseurl()
{
	return m_baseurl;
}

std::string FileUnit::gettitle()
{
	return m_title;
}

Vector<celldef*>& FileUnit::getcelllist()
{
	return m_celllist;
}

void FileUnit::setbaseurl(std::string url)
{
	m_baseurl = url;
}

void FileUnit::settitle(std::string title)
{
	m_title = title;
}

void FileUnit::testchangefile()
{
	FILE *file = fopen(m_filename.c_str(), "rb+");
	if (file)
	{
		int res = fseek(file, m_title.size() + 1, SEEK_SET);
		if(res < 0)
		{
			fclose(file);
			return;
		}
		const char* a = "a";
		fwrite(a, 1, 1, file);
		//fprintf(file, "%s",a);
		fclose(file);
	}
}