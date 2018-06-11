module Main where


type Base = [String]
type Codewords = [String]

xorc :: Char -> Char -> Char
xorc '1' '0' = '1'
xorc '0' '1' = '1'
xorc _ _     = '0'

xors :: String -> String -> String
xors [] []           = []
xors [] (y:ys)       = error "Invalid string length"
xors (x:xs) []       = error "Invalid string length"
xors (x:xs) (y:ys)   = r:(xors xs ys)
                    where r = xorc x y

makeDouble :: String -> String
makeDouble s = s++s

all0 :: Int -> String
all0 n = replicate n '0'

all1 :: Int -> String
all1 n = replicate n '1'

half01 :: Int -> String
half01 n = (all0 n) ++ (all1 n)

wlength :: Base -> Int
wlength [] = 0
wlength (l:ls) = length l 

nextB :: Base -> Base
nextB ls = (half01 n):expanded
    where n = (wlength ls)
          expanded = map makeDouble ls

makeBase :: Int -> Base
makeBase 0 = ["0", "1"]
makeBase n = nextB $ makeBase (n-1)

xorOthers :: Codewords -> Codewords
foo (x:xs) = map (xors x) xs

xorIt :: Codewords -> Codewords
xorIt [] = []
xorIt cs = xorOthers cs ++ (xorIt (tail cs))

makeCodewords :: Base -> Codewords
makeCodewords bs = bs ++ []
    -- Main
main :: IO ()
main = do
    putStrLn "Welcome to the H5 (Reed-Muller) test suite"
    putStrLn "Generating base vectors..."
    let base5 = makeBase 5
    print "Generating codewords..."

