local LoginRes = class("LoginRes")

function LoginRes:initialize(resultCode)
    self.resultCode = resultCode
end

return LoginRes