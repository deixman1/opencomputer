--https://i.imgur.com/9aw0a6E.gifv
--блоки руды сверху в сундук закидывать
--сыпуху вниз будет скидывать
--перед роботом не забудьте поставить подставку, так будет точнее ставить
 
local r = require('robot')
 
while true do
  r.select(1)
  if r.suckUp(64) then
    local rep = r.count(1)
    for i=1,rep do
      r.place()
      while not r.swing() do
        os.sleep(0)
      end
    end
 
    for i=1, r.inventorySize() do
      if r.count(i) > 0 then
        r.select(i)
        r.dropDown(64)
      end
    end
  else
    os.sleep(15)
  end
end
