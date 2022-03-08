import com.ibm.dbb.build.*

new CreatePDS().dataset("USR1.BUILD.COBOL").options("cyl space(1,1) lrecl(80) dsorg(PO) recfm(F,B) dsntype(library) msg(1)").execute()
new CreatePDS().dataset("USR1.BUILD.OBJ").options("cyl space(1,1) lrecl(80) dsorg(PO) recfm(F,B) dsntype(library) msg(1)").execute()

def file = new File("/u/mit0008/dbb-zappbuild/scripts/testsLS/cobol/test1.cbl")
def copy = new CopyToPDS()
copy.setFile(file)
copy.setDataset("USR1.BUILD.COBOL")
copy.setMember("HELLO")
copy.execute()


def compile = new MVSExec().pgm("IGYCRCTL").parm("LIB")
compile.dd(new DDStatement().name("SYSIN").dsn("USR1.BUILD.COBOL(HELLO)").options("shr"))
compile.dd(new DDStatement().name("SYSLIN").dsn("USR1.BUILD.OBJ(HELLO)").options("shr"))
compile.dd(new DDStatement().name("SYSUT1").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT2").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT3").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT4").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT5").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT6").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT7").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT8").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT9").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT10").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT11").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT12").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT13").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT14").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT15").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT16").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSUT17").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("SYSMDECK").options("cyl space(5,5) unit(vio) new"))
compile.dd(new DDStatement().name("TASKLIB").dsn("IGY.V6R1M0.SIGYCOMP").options("shr"))
compile.dd(new DDStatement().name("SYSPRINT").options("cyl space(5,5) unit(vio) new"))
compile.copy(new CopyToHFS().ddName("SYSPRINT").file(new File("/u/usr1/build/helloworld.log")))

def rc = compile.execute()

if (rc > 4)
	println("Compile failed!  RC=$rc")
else
	println("Compile successful!  RC=$rc")


