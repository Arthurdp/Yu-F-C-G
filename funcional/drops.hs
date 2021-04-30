module Drops where
import Cartas

-- 90% 10%
-- 1,2 e 3,4

drops1 :: Carta
drops1 = dropar [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, calculo2, haskell, sono]

-- 70% 30%
-- 1,2 e 3,4
drops2 :: Carta
drops2 = dropar [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, 
  calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, leda, repLEDA, leda]

-- 90% 10%
-- 3,4 e 5,6
drops3 :: Carta
drops3 = dropar [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo]

-- 70% 30%
-- 3,4 e 5,6
drops4 :: Carta
drops4 = dropar [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo, crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro]


-- 90% 10%
-- 5,6 e 7,8
drops5 :: Carta
drops5 = dropar [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta]

-- 70% 30%
-- 5,6 e 7,8
drops6 :: Carta
drops6 = dropar [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte]

-- 90% 10%
-- 7,8 e 9
drops7 :: Carta
drops7 = dropar [ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc] 

-- 70% 30%
-- 7,8 e 9
drops8 :: Carta
drops8 = dropar[ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc,
  colacao, tcc, formaturaCara, projetoEmComputacao2, emprego, laguinho, greve]

-- 60% 40%
-- 9
drops9 :: Carta
drops9 = dropar [colacao, formaturaCara, tcc, projetoEmComputacao2, emprego, laguinho, greve,
 fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster, falheiEmTudo, ressaca,
  trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1]


dropar :: [Carta] -> Carta
dropar lista = do 
  let x = geraDeckEmbaralhado lista
  dropar1 x
  
dropar1 :: [Carta] -> Carta
dropar1 (x:xs) = x
  





