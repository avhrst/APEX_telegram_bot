CREATE OR REPLACE EDITIONABLE FUNCTION  "FDEBUG" RETURN NUMBER IS 
    v_res INT; 
BEGIN 
    SELECT 
        debug 
    INTO v_res 
    FROM 
        bot_setting; 
 
    RETURN v_res; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN 0; 
END; 
/

CREATE OR REPLACE EDITIONABLE FUNCTION  "FHOST" RETURN VARCHAR2 IS 
    v_ws VARCHAR2(199); 
BEGIN 
    SELECT 
        lower(workspace) 
    INTO v_ws 
    FROM 
        apex_applications 
    WHERE 
            1 = 1 
        AND application_id = v('APP_ID'); 
 
    return(owa_util.get_cgi_env('REQUEST_PROTOCOL') 
           || '://' 
           || owa_util.get_cgi_env('HTTP_HOST') 
           || owa_util.get_cgi_env('SCRIPT_NAME') 
           || '/' 
           || v_ws); 
 
END; 
/

CREATE OR REPLACE EDITIONABLE FUNCTION  "FREST_URL" RETURN VARCHAR2 IS 
    v_res VARCHAR2(199); 
BEGIN 
    SELECT 
        rest_url 
    INTO v_res 
    FROM 
        bot_setting; 
 
    RETURN v_res; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN NULL; 
END; 
/

CREATE OR REPLACE EDITIONABLE FUNCTION  "FTOKEN" RETURN VARCHAR2 IS 
    v_res VARCHAR2(199); 
BEGIN 
    SELECT 
        token 
    INTO v_res 
    FROM 
        bot_setting; 
 
    RETURN v_res; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN NULL; 
END; 
/

CREATE OR REPLACE EDITIONABLE FUNCTION  "FWEBHOOK_URL" RETURN VARCHAR2 IS 
    v_res VARCHAR2(199); 
BEGIN 
    SELECT 
        webhook_url 
    INTO v_res 
    FROM 
        bot_setting; 
 
    RETURN v_res; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN NULL; 
END; 
/

CREATE OR REPLACE EDITIONABLE PROCEDURE  "BOT_IN_POINT" as v_ex 
int; 
 
BEGIN 
 -- проверка и регистрация пользователя --    
        telegram.check_user(v_ex); 
    IF v_ex = 0 THEN 
        return; 
    END IF; 
-- прочитаем значения сесии --    
        telegram.get_session; 
    IF telegram.in_text = '/start' THEN 
        telegram.sendmessage(p_text => 'Bot start menu'); 
        return; 
    END IF; 
 
    telegram.sendmessage(p_text => 'Bot ansver:' || telegram.in_text); 
END bot_in_point; 
/

