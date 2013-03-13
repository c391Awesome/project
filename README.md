project
=======

To build the project, run

    ant compile
  
from the root folder. This will build the project and deploy it to the work/ folder.

To make life easy, you can add a link from your catalina webapps folder to the work folder with the following command:

    ln -s path_to_work_file deployedProject/
    
    eg. ln -s proj1/work  project/

Before doing this, you should create the file WEB-INF/dbCreds.txt with your database credentials. The first line should be your username, and the second should be your password.


## project layout
<dd>
<dt>WEB-INF/</dt><dl>files from here are deployed to work/WEB-INF/</dl>
<dt>src/</dt><dl>files from here are compiled and deployed to work/WEB-INF/classes/</dl>
<dt>web/</dt><dl>files from here are deployed to work/WEB-INF</dl>
<dt>sql/</dt><dl>files from here are not deployed anywhere.</dl>
<dt>dist/</dt><dl>this folder is created by ant, it would contain a WAR file if we built one</dl>
<dt>build.xml</dt><dl>this file is our ant configuration</dl>
</dd>
