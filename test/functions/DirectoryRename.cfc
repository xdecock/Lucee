component extends="org.lucee.cfml.test.LuceeTestCase"{
	function beforeAll(){
		variables.name=ListFirst(ListLast(getCurrentTemplatePath(),"\/"),".");
		variables.parent=getDirectoryFromPath(getCurrentTemplatePath())&name&"/";
		
	}
	function afterAll(){
		directorydelete(parent,true);
	}
	function run( testResults , testBox ) {
		describe( "test case for directoryRename", function() {
			it(title = "Checking with directoryRename", body = function( currentSpec ) {
				cflock(name="testdirectoryDelete" timeout="1" throwontimeout="no" type="exclusive"){
					dir=parent&createUUID();
					nn="DirectoryRename-"&createUUID();
					dir2=parent&nn;
					directoryCreate(dir);
					directoryRename(dir,dir2);
					assertEquals("#false#", "#directoryExists(dir)#");
					assertEquals("#true#", "#directoryExists(dir2)#");

					directorydelete(dir2,true);
					directoryCreate(dir);
					directoryRename(dir,nn);
					assertEquals("#false#", "#directoryExists(dir)#");
					assertEquals("#true#", "#directoryExists(dir2)#");
				}
			});
		});	
	}
}