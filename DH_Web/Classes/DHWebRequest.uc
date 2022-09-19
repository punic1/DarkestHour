//==============================================================================
// Darkest Hour: Europe '44-'45
// Darklight Games (c) 2008-2022
//==============================================================================

class DHWebRequest extends WebRequest;

enum EHTTPMethod
{
    HTTP_GET,
    HTTP_POST,
    HTTP_DELETE
};

var EHTTPMethod HTTPMethod;

function string GetURIType(int MaxTypeLength)
{
    local string Tail;

    Tail = Right(URI, MaxTypeLength);

    return Mid(Tail, InStr(Tail, "."));
}