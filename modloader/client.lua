addEvent = addEvent
addEventHandler = addEventHandler
triggerServerEvent = triggerServerEvent
ipairs = ipairs
downloadFile = downloadFile
root = root

self = {};
self.models = {};

addEvent('download.models', true);
addEventHandler('download.models', root, function(table)
	if table then
		self.models = table;
		for index, value in ipairs(self.models) do
			downloadFile(value.file);
		end
	end
end);

addEventHandler('onClientFileDownloadComplete', root, function(name, success)
	if (source == resourceRoot) then
		if success then
			for index, value in ipairs(self.models) do
				if value.file == name then
					if name:find('.dff') then
						self.dff = EngineDFF(name);
						self.dff:replace(value.model);
					elseif name:find('.txd') then
						self.txd = EngineTXD(name);
						self.txd:import(value.model);
					end
				end
			end
		end
	end
end);

triggerServerEvent('check.models', localPlayer);