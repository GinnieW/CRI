import Pkg
Pkg.add("XLSX")
Pkg.add("DataFrames")
using XLSX
using DataFrames
dir = pwd()
fname = "firmDtd.xlsx"
file = string(dir,"\\",fname)
xf = XLSX.readxlsx(file)
Dtd = xf["Tabelle1"]
ans = ExtractMthEnd(Dtd)
df = DataFrames.DataFrame(company = ans[:,1] , date = ans[:,2] , Dtd = ans[:,3])
XLSX.writetable("MthEndDtd.xlsx", collect(DataFrames.eachcol(df)), DataFrames.names(df))
