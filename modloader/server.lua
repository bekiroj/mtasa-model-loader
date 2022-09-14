triggerLatentClientEvent = triggerLatentClientEvent
addEvent = addEvent
addEventHandler = addEventHandler
ipairs = ipairs
tonumber = tonumber

self = {};
self.models = {};
self.meta = XML.load('meta.xml');

for index, value in ipairs(self.meta.children) do
	if value.name == 'file' then
		self.model = tonumber(value:getAttribute('model'));
		self.file = value:getAttribute('src');
		if self.file:find('.txd') then
			table.insert(self.models, {file = self.file, model = self.model});
		end
	end
end

for index, value in ipairs(self.meta.children) do
	if value.name == 'file' then
		self.model = tonumber(value:getAttribute('model'));
		self.file = value:getAttribute('src');
		if self.file:find('.dff') then
			table.insert(self.models, {file = self.file, model = self.model});
		end
	end
end

addEvent('check.models', true);
addEventHandler('check.models', root, function ()
	triggerLatentClientEvent(client, 'download.models', client, self.models);
end);
