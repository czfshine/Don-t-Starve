--Here is where you can select a language file to override the default english strings
--The game currently only supports ASCII (sadly), so not all languages can be supported at this time.

require "translator"

if APP_REGION == "SCEJ" then
	LanguageTranslator:LoadPOFile("scripts/languages/japanese.po", "jp")
end

