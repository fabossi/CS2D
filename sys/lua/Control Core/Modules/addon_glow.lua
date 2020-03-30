
addhook("serveraction","glowz")
function glowz(id,glo)
if (glo==2) then
glowx(id)
end
end

function glowx(id)
menu (id,"Glow Menu,Glow Red,Glow Blue,Glow Green,Glow Yellow,Glow White,Glow Pink,No Glow")
end

addhook("menu","glowxz")
function glowxz(id,menu,sel)
if (menu=="Glow Menu") then
if (sel<=0) then
glowx(id)
end

if (sel==1) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,255,0,0)
end

if (sel==2) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,0,0,255)
end

if (sel==3) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,0,255,0)
end

if (sel==4) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,255,220,0)
end

if (sel==5) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,255,255,255)
end

if (sel==6) then
freeimage(id)
id1=image("gfx/sprites/flare2.bmp",0,0,100+id)
imagescale(id1,1,1)
imageblend(id1,1)
imagealpha(id1,0.7)
imagecolor(id1,255,0,255)
end

if (sel==7) then
freeimage(id)


end
end
end