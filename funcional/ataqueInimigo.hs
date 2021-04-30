module AtaqueInimigo where

import Cartas

ataqueMaisForte1 :: [Carta] -> Int
ataqueMaisForte1 [] = 0
ataqueMaisForte1 (x:xs) = max (ataque x) (ataqueMaisForte1 (xs))

ataqueMaisForte :: [Carta] -> Carta
ataqueMaisForte [] = cartaVazia
ataqueMaisForte (x:xs)                 
 |ataque x == n = x 
 |otherwise = ataqueMaisForte xs 
  where n = ataqueMaisForte1 (x:xs)

defesaMaisForte1 :: [Carta] -> Int
defesaMaisForte1 [] = 0
defesaMaisForte1 (x:xs) = max (defesa x) (defesaMaisForte1 (xs))

defesaMaisForte :: [Carta] -> Carta
defesaMaisForte (x:xs)                 
 |defesa x == n = x
 |otherwise = defesaMaisForte xs 
 where n = defesaMaisForte1 (x:xs)

ataqueMaisFraco1 :: [Carta] -> Int
ataqueMaisFraco1 [] = 4000
ataqueMaisFraco1 (x:xs) = min (ataque x) (ataqueMaisFraco1 (xs))

ataqueMaisFraco :: [Carta] -> Carta
ataqueMaisFraco (x:xs)                 
 |ataque x == n = x
 |otherwise = ataqueMaisFraco xs 
 where n = ataqueMaisFraco1 (x:xs)

defesaMaisFraca1 :: [Carta] -> Int
defesaMaisFraca1 [] = 4000
defesaMaisFraca1 (x:xs) = min (defesa x) (defesaMaisFraca1 (xs))

defesaMaisFraca :: [Carta] -> Carta
defesaMaisFraca (x:xs)                 
 |defesa x == n = x
 |otherwise = defesaMaisFraca xs
 where n = defesaMaisFraca1 (x:xs)

pegaModoDefesa :: [Carta] -> [Carta]
pegaModoDefesa [] = []
pegaModoDefesa (x:xs)
 |not (modoAtaque x) = (x:(pegaModoDefesa xs))
 |otherwise = pegaModoDefesa xs

pegaModoAtaque :: [Carta] -> [Carta]
pegaModoAtaque [] = []
pegaModoAtaque (x:xs)
 |modoAtaque x = (x:(pegaModoAtaque xs))
 |otherwise = pegaModoAtaque xs

logicaAtaque :: [Carta] -> [Carta] -> Carta
logicaAtaque x y
 |(ataque cartaAtaque) > defesa maiorDefesaDef = maiorDefesaDef
 |(ataque cartaAtaque) > ataque maiorAtaqueAta = maiorAtaqueAta
 |verificaMenorD cartaAtaque (pegaModoDefesa x) = pegaMenorD cartaAtaque (pegaModoDefesa x)
 |verificaMenorA cartaAtaque (pegaModoAtaque x) = pegaMenorA cartaAtaque (pegaModoAtaque x)
 |otherwise = menorDefesaDef
 where cartaAtaque = (ataqueMaisForte (pegaModoAtaque y))
       maiorDefesaDef = (defesaMaisForte (pegaModoDefesa x))
       menorDefesaDef = (defesaMaisFraca (pegaModoDefesa x)) 
       maiorAtaqueAta = (ataqueMaisForte (pegaModoAtaque x))

verificaMenorD :: Carta -> [Carta]-> Bool
verificaMenorD carta [] = False
verificaMenorD carta (x:xs)
 |(ataque carta) > defesa x = True
 |otherwise = verificaMenorD carta xs

pegaMenorD :: Carta -> [Carta] -> Carta
pegaMenorD carta (x:xs)
 |(ataque carta) > defesa x = x
 |otherwise = pegaMenorD carta xs

verificaMenorA :: Carta -> [Carta]-> Bool
verificaMenorA carta [] = False
verificaMenorA carta (x:xs)
 |(ataque carta) > ataque x = True
 |otherwise = verificaMenorA carta xs

pegaMenorA :: Carta -> [Carta] -> Carta
pegaMenorA carta (x:xs)
 |(ataque carta) > ataque x = x
 |otherwise = pegaMenorA carta xs

geraDeckEmbaralhado :: [Carta] -> [Carta]
geraDeckEmbaralhado [] = []
geraDeckEmbaralhado cartas = carta:geraDeckEmbaralhado (removeCarta (iD carta) cartas)  
    where carta = (cartaAleatoria cartas)

cartaAleatoria :: [Carta] -> Carta
cartaAleatoria lista = (lista !! unsafePerformIO(randomRIO (0, (length lista) - 1)))