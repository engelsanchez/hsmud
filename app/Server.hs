module Main where

import MudLib
import System.IO
import Network.Socket

main :: IO ()
main = do
    sock <- socket AF_INET Stream 0
    setSocketOption sock ReuseAddr 1
    bindSocket sock (SockAddrInet 9000 iNADDR_ANY)
    listen sock 2
    mainLoop sock

mainLoop sock = do
    (conn, _) <- accept sock
    hconn <- socketToHandle conn ReadWriteMode
    runConn hconn
    mainLoop sock

runConn sock = do
    cmd <- hGetLine sock
    hPutStrLn sock cmd
    runConn sock
   
     
