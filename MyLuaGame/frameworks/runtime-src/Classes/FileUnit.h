#ifndef __FILEUNIT_HEAD__
#define __FILEUNIT_HEAD__

#include "cocos2d.h"
#include <string>
#include <vector>
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
	std::string m_rowname;
	std::string m_url;
	unsigned long m_begin;
	unsigned long m_size;
	std::string m_content;

	std::string getrowname() {return m_rowname;}
	std::string geturl() {return m_url;}
	std::string getcontent() {return m_content;}
	void setrowname(std::string l) {m_rowname = l;}
	void seturl(std::string l) {m_url = l;}
	void setcontent(std::string l) {m_content = l;}
};
class FileUnit
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
	std::string m_baseurl;
	std::string m_title;
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