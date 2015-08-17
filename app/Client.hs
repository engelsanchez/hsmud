module Main where

import MudLib
import System.IO
import Network.Socket

main :: IO ()
main = do
    sock <- socket AF_INET Stream 0
    addr <- inet_addr "127.0.0.1"
    connect sock (SockAddrInet 9000 addr)
    h <- socketToHandle sock ReadWriteMode
    readCmds h

readCmds sock = do
    line <- getLine
    hPutStrLn sock line
    resp <- hGetLine sock
    putStrLn resp
    readCmds sock
