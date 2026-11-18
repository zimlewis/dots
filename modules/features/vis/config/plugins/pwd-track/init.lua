local M = {
	pwd = ''
}

-- Set $PWD environment variable as pwd
function M:set_from_env()
	self.pwd = os.getenv('PWD')
end

-- Get saved $PWD
function M:get_pwd()
	return self.pwd
end

function M:set_pwd(p)
	self.pwd = p
end

return M
