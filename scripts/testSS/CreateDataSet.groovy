import com.ibm.dbb.build.*

new CreatePDS().dataset("mit0003.BUILD.COBOL").options("cyl space(1,1) lrecl(80) dsorg(PO) recfm(F,B) dsntype(library) msg(1)").execute()
new CreatePDS().dataset("mit0003.BUILD.OBJ").options("cyl space(1,1) lrecl(80) dsorg(PO) recfm(F,B) dsntype(library) msg(1)").execute()

