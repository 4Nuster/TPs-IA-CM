from pysat.formula import CNF
from pysat.solvers import Glucose3

#chargement de la CN
fichier = open(r'test1.cnf',"w+")

#l'ajout du litéral
phi = input("literal: ")

#calcul du l'inverse du litéral
inv_phi = phi.split()
#print(inv_phi)

fichier.write('p cnf 5 '+str(9+len(inv_phi)))
fichier.write('\n2 -3 0\n-3 0\n1 -2 -3 4 0\n-1 -4 0\n-1 -2 3 5 0\n2 -5 0\n-3 4 -5 0\n1 2 5 0\n-3 5 0\n ')

#l'ajout du l'inverse du litéral
for i in inv_phi:
  fichier.write(str(-int(i))+" 0\n")
fichier.close()

g = Glucose3()
f1 = CNF(from_file='test1.cnf') 

for i in f1:
  g.add_clause(i)

#exécution
if(not g.solve()):
  print("CN infers phi")
else:
  print("CN doesn't infer phi")