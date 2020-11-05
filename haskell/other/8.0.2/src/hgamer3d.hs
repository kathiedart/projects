{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE UnicodeSyntax     #-}

import           HGamer3D
import           System.Clock

config ∷ Graphics3DConfig
config = Graphics3DConfig
    (EngineConfig False True True True)
    (GraphicsQuality High High High High)
    (Logging Debug False "hg.log")
    (WindowG3D 1920 1080 True True False)

logic ∷ GameLogicFunction
logic = const $ return ()

time ∷ GameTime
time = TimeSpec 0 0

main ∷ IO ()
main = runGame config logic time