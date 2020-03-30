--------------------------------------------------
--        		 	HAT SYSTEM	                --
--------------------------------------------------
-- Este é um módulo oficial do Control Core.
--------------------------------------------------
--                    Hooks                     --
--------------------------------------------------
addhook('serveraction', 'm_serveraction')
addhook('startround', 'm_startround')
addhook('menu', 'm_menu')
--------------------------------------------------
--              	 Constants                  --
--------------------------------------------------
hats_directory = "gfx/hats/"
image_directory = "gfx/images/"
--------------------------------------------------
--              	 Arrays                     --
--------------------------------------------------
p_hats = init_array(32,"")
p_hatsdir = init_array(32,"")
--------------------------------------------------
--           	    Functions                   --
--------------------------------------------------
function create_menu_list(menu_table)
	local path = "sys/servertransfer.lst"
	local file = io.open(path,"r")
	local array = {}
	for line in file:lines() do 
		print(line)
		table.insert(array,line)
	end
	file:close()
	if #array ~= #menu_table then
		file = io.open(path,"w+")
		for i in ipairs(menu_table) do
			file : write(hats_directory..menu_table[i].."\n")
		end
		msg3(get_color("sv").."[Server] Pasta de hats alterada!",1000)
		c_refresh()
		file:close()
	end	
end

function get_menu_item(menu_id,button)
	local item = 7*(menu_id-1) + button
	return t_hats[item]
end

function show_menu(uid, page)
	menu_id = page or 1
	
	local menu_length = math.ceil(#t_hats / 7)
	local content = 'Pagina '.. menu_id
	
	if menu_id < 1 then 
		menu_id = menu_length 
	elseif menu_id > menu_length then 
		menu_id = 1 
	end
	for	i = 7 * menu_id - 6, 7 * menu_id do
		if t_hats[i] then 
			content = content ..', '.. t_hats[i] 
		else 
			content = content ..',' 
		end
	end
	if menu_id == menu_length then 
		content = content ..',(Proximo)' 
	else 
		content = content ..',Proximo' 
	end
	if menu_id == 1 then 
		content = content ..',(Anterior)' 
	else 
		content = content ..',Anterior' 
	end
	menu(uid, content)
end

function m_menu(uid, title, button)
	if title:sub(1, 6) == 'Pagina' then
		if button == 8 then show_menu(uid, menu_id + 1) end
		if button == 9 then show_menu(uid, menu_id - 1) end
		if button <= 7 then
			path = get_menu_item(menu_id,button)
			if path == "Remover imagem" then
				if p_hats[uid] ~= "" then
					freeimage(p_hats[uid])
					p_hats[uid] = ""
					p_hatsdir[uid] = ""
				end	
			else
				if p_hats[uid] ~= "" then
					freeimage(p_hats[uid])
				end
				p_hatsdir[uid] = hats_directory..path
				p_hats[uid] = image(p_hatsdir[uid], 1, 0, 200 + uid)
			end	
		end
	end
end

function m_serveraction(uid, action)
	if action == 3 and p_level[uid] > 0 then
		show_menu(uid)
	end
end

function m_startround()
	for _,uid in pairs(player(0, 'tableliving')) do
		if p_hats[uid] ~= "" and p_level[uid] > 0 then
			p_hats[uid] = image(p_hatsdir[uid], 1, 0, 200 + uid)
		end
	end
end

t_hats = read_dir(hats_directory,true,false,true)
create_menu_list(t_hats)
table.insert(t_hats,1,"Remover imagem")