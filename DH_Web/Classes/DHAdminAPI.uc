//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHAdminAPI extends WebApplication;

struct STestDataItem
{
    var string ROID;
    var string Name;
};
var array<STestDataItem> TestData;

function Init()
{
    Log("Admin API: started and listening on port" @ WebServer.ListenPort);
}

event Query(WebRequest Request, WebResponse Response)
{
    local DHWebRequest Req;

    Req = DHWebRequest(Request);

    Log("Admin API: request" @ Req.URI);

    switch (Req.URI)
    {
        case "/":
            ShowPage(Response, "/src/index.html");
            return;
        case "/test":
            HandleTest(Req, Response);
            return;
        default:
            if (ServeFiles(Req, Response)) return;
    }
}

function bool ServeFiles(DHWebRequest Request, WebResponse Response)
{
    switch (Request.GetURIType(4))
    {
        case ".css":
            Response.SendCachedFile(Path $ Request.URI, "text/css");
            return true;
        case ".js":
            Response.SendCachedFile(Path $ Request.URI, "text/javascript");
            return true;
        case ".svg":
            Response.SendStandardHeaders("image/svg", true);
            Response.IncludeBinaryFile(Path $ Request.URI);
            return true;
        case ".png":
            Response.SendStandardHeaders("image/png", true);
            Response.IncludeBinaryFile(Path $ Request.URI);
            return true;
        default:
            Response.HTTPError(404);
            return false;
    }
}

function ShowPage(WebResponse Response, string Page)
{
	Response.IncludeUHTM(Path $ Page);
	Response.ClearSubst();
}

// TEST

function HandleTest(DHWebRequest Request, WebResponse Response)
{
    switch (Request.HTTPMethod)
    {
        case HTTP_GET:
            Response.SendStandardHeaders("application/json", false);
            Response.bSentText = true;
            Response.SendText(SerializeTestData().Encode());
            return;
    }
}

function JSONObject SerializeTestData()
{
    local JSONArray JSONData;
    local int i;

    JSONData = class'JSONArray'.static.Create();

    for (i = 0; i < TestData.Length; ++i)
    {
        JSONData.Add((new class'JSONObject').PutString("roid", TestData[i].ROID).PutString("name", TestData[i].Name));
    }

    return (new class'JSONObject').Put("data", JSONData);
}

defaultproperties
{
    TestData(0)=(ROID="76561197989090226",Name="Napoleon Blownapart")
    TestData(1)=(ROID="76561197960644559",Name="Basnett")
    TestData(2)=(ROID="76561198043869714",Name="DirtyBirdy")
    TestData(3)=(ROID="76561198066643021",Name="Patison")
    TestData(4)=(ROID="76561198046844470",Name="Matty")
    TestData(5)=(ROID="76561197991612787",Name="Razorneck")
    TestData(6)=(ROID="76561198025788618",Name="WOLFkraut")
    TestData(7)=(ROID="76561197992062636",Name="eksha")
    TestData(8)=(ROID="76561197989139694",Name="mimi")
    TestData(9)=(ROID="76561198020507621",Name="jwjw")
    TestData(10)=(ROID="76561198176185585",Name="Backis")
    TestData(11)=(ROID="76561198162915303",Name="Caverne")
}