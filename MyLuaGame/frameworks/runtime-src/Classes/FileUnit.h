#ifndef __FILEUNIT_HEAD__
#define __FILEUNIT_HEAD__

#include "cocos2d.h"
#include <string>
#include <vector>
#include "fileeditsys.h"
USING_NS_CC;
class celldef : public Ref
{
public:
	static celldef* create() {
		celldef* c = new celldef();
		c->autorelease();
		return c;
	}
public:
	std::string m_path;
	std::string m_title;
	std::string m_content;

	std::string getpath() {return m_path;}
	std::string gettitle() {return m_title;}
	std::string getcontent() {return m_content;}
	void setpath(std::string l) {m_path = l;}
	void settitle(std::string l) {m_title = l;}
	void setcontent(std::string l) {m_content = l;}
};
class FileUnit//index->dir->bookname->bookchapter->bookcontent
{
public:
	FileUnit(std::string filename);
	~FileUnit();
public:
	bool isfileexit();
	void addrow(std::string row, std::string url, std::string content);
	bool isrowexist(std::string row);
	std::string getrowcontent(std::string row);
	void setrow(std::string row, std::string content);
	void clear();
	
	void savedata();


	void settestdata();
	void testchangefile();
	/////
	std::string getbaseurl();
	std::string gettitle();
	Vector<celldef*>& getcelllist();
	void setbaseurl(std::string url);
	void settitle(std::string title);
public:
	void destroy(){delete this;}
private:
	std::string m_filename;
	fileeditsys* m_pfileeditsys;
	union
	{
		struct
		{
			char a;
			char b;
			char c;
			char d;
		};
		unsigned long len;
		long length;
	} unionlen;
	Vector<celldef*> m_celllist;
	void loaddata(std::vector<char> input);
};

#endif