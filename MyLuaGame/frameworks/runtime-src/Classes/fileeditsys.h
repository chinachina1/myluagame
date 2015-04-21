#ifndef __FILEEDITSYS_HEAD__
#define __FILEEDITSYS_HEAD__
#include <string>
#include <vector>
#include "cocos2d.h"

using namespace std;
USING_NS_CC;

#define fpos unsigned long
namespace filesys
{
	struct treecell 
	{
		fpos beginpos;
		fpos brotherpos;
		fpos childpos;
		string title;
		string content;
		string flag;
		treecell()
		{
			brotherpos = 0;
			beginpos = 0;
			childpos = 0;
		}
		fpos getsize()
		{
			return sizeof(beginpos) + sizeof(brotherpos) + sizeof(childpos) + title.size() + content.size() + flag.size() + 3;
		}
	};
	struct treecellpoint 
	{
		treecell _cell;
		treecellpoint *_brother;
		treecellpoint *_child;
		treecellpoint():_brother(NULL), _child(NULL)
		{

		}
		~treecellpoint()
		{
			//if (_brother)
			//{
			//	delete _brother;
			//}
			//if (_child)
			//{
			//	delete _child;
			//}
		}
	};
}
using namespace filesys;
class fileeditsys : public Ref
{
public:
	static fileeditsys* create(string filename);
private:
	fileeditsys();
public:
	~fileeditsys();
	void destroy();
private:
	treecellpoint *m_proot;
private:
	string m_filename;
	FILE *m_filehandle;
	void setFileName(string filename);
	bool openFile();
	bool switchread();
	bool switchwrite();
	bool saveFile();
	bool closeFile();
	bool setfilepos(fpos pos);
	bool setfileposend();
	bool readpos(fpos& f);
	bool writepos(fpos p);
	bool readstring(string& s);
	bool writestring(string s);
	//////////////////////////////////////////////////////////////////////////
	bool readfiletreecelldata(treecell &t);
	bool readfilebrotherdata(treecellpoint*);
public:
	bool filedataisempty();
	treecellpoint* readgendata();
	bool readfileallbrotherdata(treecellpoint*);
	bool readfilechilddata(treecellpoint*);
	treecellpoint* findfiledata(vector<string> cmd);
	//---
	bool addfiledata(treecellpoint* parent, string title, string content);
	////newapi
	//
	bool findfiledata(vector<string> cmd, treecellpoint&);
	vector<treecell> getallbrother(vector<string> cmd);
	bool getfirstchild(vector<string> cmd, treecell&child);
	bool addfiledata(vector<string> cmd, string title, string content, string flag);
	vector<treecell> getallchild(vector<string> cmd);
private:
	int m_iotype;//0 "r"; 1 "r+"; 

	vector<char> m_readtempbuff;
	bool addfiledata(treecell&);
	bool editfiledata(treecell&);
	//newapi
	map<vector<string>, fpos> m_fastindex;
private:
	void addcashpath(vector<string> cmd, fpos fp);
	bool getcashpath(vector<string> &inandout, fpos &fp);
};

#endif