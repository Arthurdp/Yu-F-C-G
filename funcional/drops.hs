module Drops where
import Cartas


drops1 :: [Carta]
drops1 = [sePerdeu, python, fmcc1, fmcc2,calculo1]

drops2 :: [Carta]
drops2 = []

drops3 :: [Carta]
drops3 = []

drops4 :: [Carta]
drops4 = []

drops5 :: [Carta]
drops5 = []

drops6 :: [Carta]
drops6 = []

drops7 :: [Carta]
drops7 = []

drops8 :: [Carta]
drops8 = []

drops9 :: [Carta]
drops9 = []

dropar :: [Carta] -> Carta
dropar lista = do 
  let x = geraDeckEmbaralhado lista
  dropar1 x
  
dropar1 :: [Carta] -> Carta
dropar1 (x:xs) = x
  





