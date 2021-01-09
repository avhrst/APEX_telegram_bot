CREATE OR REPLACE EDITIONABLE PACKAGE  "TELEGRAM" AS 
    v_err_msg CLOB; 
    p_url CLOB := 'https://api.telegram.org/bot'; 
    p_token VARCHAR(200) := ftoken; 
    p_debug INT := fdebug;  
  
    -- параметры входящего сообщения --  
        in_chat_id INT;                                     -- chat id  
        in_message_id INT;                                 -- messaage id  
        in_text VARCHAR2(32000);                   -- message text  
        in_phone_number VARCHAR2(100);                     -- phone number  
        in_first_name 
    VARCHAR2(100);                  -- first name user  
        in_last_name VARCHAR2(100);                   -- last name user  
        in_vcard VARCHAR2(1000); 
    in_callback_query_id INT;  
    -- callback --  
        in_data VARCHAR2(1024);                   -- callback data  
    -- параметры сессиии --  
        session_st INT;                    -- текущее значение шага --  
        session_menu VARCHAR2(100);         -- текущее значение меню --  
        session_text VARCHAR2(4000);  
  
    -- настройка webhook для входящих сообщений --  
        PROCEDURE 
    setwebhook ( 
        p_webhook_url IN VARCHAR 
    );  
  
    -- отправка сообщения --  
        PROCEDURE sendmessage ( 
        p_chat_id            INT DEFAULT in_chat_id, 
        p_text               IN  CLOB, 
        p_parse_mode         IN  VARCHAR DEFAULT 'HTML', 
        p_resize_keyboard    IN  BOOLEAN DEFAULT true, 
        p_one_time_keyboard  IN  BOOLEAN DEFAULT true, 
        p_buttons_colum      IN  INT DEFAULT 2, 
        p_reply_markup       IN  VARCHAR DEFAULT NULL 
    );  
  
    -- редактировать сообщение --  
        PROCEDURE editmessage ( 
        p_chat_id            INT DEFAULT in_chat_id, 
        p_message_id         INT DEFAULT in_message_id, 
        p_text               IN  CLOB, 
        p_parse_mode         IN  VARCHAR DEFAULT 'HTML', 
        p_resize_keyboard    IN  BOOLEAN DEFAULT true, 
        p_one_time_keyboard  IN  BOOLEAN DEFAULT true, 
        p_buttons_colum      IN  INT DEFAULT 2, 
        p_reply_markup       IN  VARCHAR DEFAULT NULL 
    ); 
 
    PROCEDURE deletemessage ( 
        p_chat_id     INT DEFAULT in_chat_id, 
        p_message_id  INT DEFAULT in_message_id 
    );  
  
    -------------------------  
        PROCEDURE editmessagereplymarkup ( 
        p_chat_id        INT DEFAULT in_chat_id, 
        p_message_id     INT DEFAULT in_message_id, 
        p_buttons_colum  INT DEFAULT 2 
    );  
  
    -------------------------  
        PROCEDURE answercallbackquery ( 
        p_callback_query_id  IN  INT, 
        p_text               IN  VARCHAR, 
        p_show_alert         IN  BOOLEAN DEFAULT false 
    );  
  
    -------------------------  
  
    -- разбор входящего сообщения --  
        PROCEDURE in_parse ( 
        p_body CLOB 
    );  
  
    -- проверка и регистрация пользователя --  
        PROCEDURE check_user ( 
        v_ex OUT NUMBER 
    );  
  
    -- сброс счетчика шагов --  
        PROCEDURE reset_st ( 
        p_chat_id IN INT DEFAULT in_chat_id 
    );  
  
    -- запись сесии --  
        PROCEDURE save_session ( 
        v_menu  IN  VARCHAR2 DEFAULT NULL, 
        v_st    IN  INT DEFAULT 0 
    );  
  
    --   получение сесии --  
        PROCEDURE get_session; 
 
    FUNCTION clr_phone ( 
        v_phone IN VARCHAR2 
    ) RETURN VARCHAR2;  
  
    -- авторизация пользователя через телеграм --  
        PROCEDURE auth_pin ( 
        v_username IN VARCHAR2 
    );  
  
    -- сообщение о входе в приложение --  
        PROCEDURE auth_reg ( 
        v_username  IN  VARCHAR2, 
        v_app_name  IN  VARCHAR2 
    );  
  
    -- служебная функция преобразования --  
        FUNCTION blob2clob ( 
        p_blob       IN  BLOB, 
        p_blob_csid  IN  INTEGER DEFAULT dbms_lob.default_csid 
    ) RETURN CLOB;  
  
    -- отправка  фото --  
        PROCEDURE sendimg ( 
        p_chat_id     INT DEFAULT in_chat_id, 
        p_img_id      IN  INT DEFAULT NULL, 
        p_img_url     IN  VARCHAR2 DEFAULT NULL, 
        p_text        IN  CLOB, 
        p_parse_mode  IN  VARCHAR DEFAULT 'HTML' 
    ); 
 
END telegram; 
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY  "TELEGRAM" AS 
 
    PROCEDURE add_journ ( 
        v_body     IN  CLOB DEFAULT NULL, 
        v_result   IN  CLOB DEFAULT NULL, 
        v_chat_id  IN  NUMBER DEFAULT NULL, 
        v_metod    IN  VARCHAR2 DEFAULT NULL 
    ) AS 
    BEGIN 
        INSERT INTO bot_journ ( 
            crt, 
            chat_id, 
            metod, 
            body, 
            result, 
            token 
        ) VALUES ( 
            current_date, 
            v_chat_id, 
            v_metod, 
            v_body, 
            v_result, 
            telegram.p_token 
        ); 
 
    END add_journ;  
  
    -- подготовка номера телефона (очистка от неиспользуемых символов)--  
                    FUNCTION clr_phone ( 
        v_phone IN VARCHAR2 
    ) RETURN VARCHAR2 AS 
        v_res VARCHAR2(30); 
    BEGIN 
        IF v_phone IS NULL THEN 
            RETURN NULL; 
        END IF; 
        IF v_phone LIKE '%4578744579' THEN 
            v_res := replace(v_phone, '+', ''); 
            RETURN v_res; 
        END IF; 
 
        v_res := replace(v_phone, '(', ''); 
        v_res := replace(v_res, ')', ''); 
        v_res := replace(v_res, '-', ''); 
        v_res := replace(v_res, ' ', ''); 
        v_res := replace(v_res, '+', ''); 
        v_res := replace(v_res, '/', ''); 
        v_res := replace(v_res, '\', ''); 
        v_res := replace(v_res, '|', ''); 
        v_res := replace(v_res, '.', ''); 
        v_res := replace(v_res, ',', ''); 
        v_res := substr(v_res, length(v_res) - 8); 
        RETURN '380' || v_res; 
    END clr_phone;  
  
    ----------------------  
                    FUNCTION blob2clob ( 
        p_blob       IN  BLOB, 
        p_blob_csid  IN  INTEGER DEFAULT dbms_lob.default_csid 
    ) RETURN CLOB AS 
 
        l_clob          CLOB; 
        l_dest_offset   INTEGER := 1; 
        l_src_offset    INTEGER := 1; 
        l_lang_context  INTEGER := dbms_lob.default_lang_ctx; 
        l_warning       INTEGER; 
    BEGIN 
        IF p_blob IS NULL THEN 
            RETURN NULL; 
        END IF; 
        dbms_lob.createtemporary(lob_loc => l_clob, cache => false); 
        dbms_lob.converttoclob(dest_lob => l_clob, src_blob => p_blob, amount => dbms_lob.lobmaxsize, 
                              dest_offset => l_dest_offset, 
                              src_offset => l_src_offset, 
                              blob_csid => p_blob_csid, 
                              lang_context => l_lang_context, 
                              warning => l_warning); 
 
        RETURN l_clob; 
    END blob2clob;  
  
    -- подготовка тела сообщения --  
                    FUNCTION message_body ( 
        p_chat_id            INT DEFAULT in_chat_id, 
        p_message_id         INT DEFAULT in_message_id, 
        p_text               IN  CLOB, 
        p_parse_mode         IN  VARCHAR DEFAULT 'HTML', 
        p_resize_keyboard    IN  BOOLEAN DEFAULT true, 
        p_one_time_keyboard  IN  BOOLEAN DEFAULT true, 
        p_buttons_colum      IN  INT DEFAULT 2, 
        p_reply_markup       IN  VARCHAR DEFAULT NULL 
    ) RETURN CLOB AS 
 
        v_body  CLOB; 
        v_ex1   INT; 
        v_ex2   INT; 
        v_i     INT; 
        CURSOR cur1 IS 
        SELECT 
            * 
        FROM 
            reply_markup_keyboard; 
 
        CURSOR cur2 IS 
        SELECT 
            * 
        FROM 
            reply_markup_inline_keyboard; 
 
    BEGIN 
        SELECT 
            COUNT(*) 
        INTO v_ex1 
        FROM 
            reply_markup_keyboard;  
  
        -- inline keyboard --  
                                        SELECT 
            COUNT(*) 
        INTO v_ex2 
        FROM 
            reply_markup_inline_keyboard;  
  
        -- отправляем запрос --  
                                        apex_json.initialize_clob_output; 
        apex_json.open_object; 
        apex_json.write('chat_id', p_chat_id); 
        apex_json.write('message_id', p_message_id); 
        apex_json.write('text', p_text); 
        apex_json.write('parse_mode', p_parse_mode); 
        IF p_reply_markup IS NULL THEN 
            IF v_ex1 != 0 OR v_ex2 != 0 THEN 
                v_i := 0; 
                apex_json.open_object('reply_markup'); 
                apex_json.write('one_time_keyboard', p_one_time_keyboard); 
                apex_json.write('resize_keyboard', p_resize_keyboard); 
            END IF; 
 
            IF v_ex1 != 0 THEN 
                apex_json.open_array('keyboard'); 
                apex_json.open_array(); 
                FOR c1 IN cur1 LOOP 
                    v_i := v_i + 1; 
                    apex_json.open_object; 
                    apex_json.write('text', c1.text); 
                    apex_json.write('request_contact', 1 = c1.request_contact); 
                    apex_json.close_object; 
                    IF v_i = p_buttons_colum THEN 
                        apex_json.close_array; 
                        apex_json.open_array; 
                        v_i := 0; 
                    END IF; 
 
                END LOOP; 
 
                apex_json.close_array; 
                apex_json.close_array; 
            END IF; 
 
            IF v_ex2 != 0 THEN 
                v_i := 0; 
                apex_json.open_array('inline_keyboard'); 
                apex_json.open_array(); 
                FOR c2 IN cur2 LOOP 
                    v_i := v_i + 1; 
                    apex_json.open_object; 
                    apex_json.write('text', c2.text); 
                    apex_json.write('callback_data', c2.callback_data); 
                    apex_json.close_object; 
                    IF v_i = p_buttons_colum THEN 
                        apex_json.close_array; 
                        apex_json.open_array; 
                        v_i := 0; 
                    END IF; 
 
                END LOOP; 
 
                apex_json.close_array; 
                apex_json.close_array; 
            END IF; 
 
            IF v_ex1 != 0 OR v_ex2 != 0 THEN 
                apex_json.close_object; 
            END IF; 
        ELSE 
            apex_json.write('reply_markup', p_reply_markup); 
        END IF; 
 
        apex_json.close_object; 
        v_body := apex_json.get_clob_output; 
        RETURN v_body; 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'message_body', 
                v_err_msg 
            ); 
 
    END message_body;  
  
    --отправка сообщения --  
                    PROCEDURE sendmessage ( 
        p_chat_id            INT DEFAULT in_chat_id, 
        p_text               IN  CLOB, 
        p_parse_mode         IN  VARCHAR DEFAULT 'HTML', 
        p_resize_keyboard    IN  BOOLEAN DEFAULT true, 
        p_one_time_keyboard  IN  BOOLEAN DEFAULT true, 
        p_buttons_colum      IN  INT DEFAULT 2, 
        p_reply_markup       IN  VARCHAR DEFAULT NULL 
    ) AS 
        v_body    CLOB; 
        v_result  CLOB; 
    BEGIN  
        --        insert into  
                                        v_body := message_body(p_chat_id, NULL, p_text, p_parse_mode, p_resize_keyboard, 
                              p_one_time_keyboard, 
                              p_buttons_colum, 
                              p_reply_markup); 
 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/sendMessage', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => p_chat_id, v_metod => 'sendMessage'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'sendmessage', 
                v_err_msg 
            ); 
 
    END sendmessage;  
  
    -- редактировать сообщение --  
                    PROCEDURE editmessage ( 
        p_chat_id            INT DEFAULT in_chat_id, 
        p_message_id         INT DEFAULT in_message_id, 
        p_text               IN  CLOB, 
        p_parse_mode         IN  VARCHAR DEFAULT 'HTML', 
        p_resize_keyboard    IN  BOOLEAN DEFAULT true, 
        p_one_time_keyboard  IN  BOOLEAN DEFAULT true, 
        p_buttons_colum      IN  INT DEFAULT 2, 
        p_reply_markup       IN  VARCHAR DEFAULT NULL 
    ) AS 
        v_result  CLOB; 
        v_body    CLOB; 
    BEGIN 
        v_body := message_body(p_chat_id, p_message_id, p_text, p_parse_mode, p_resize_keyboard, 
                              p_one_time_keyboard, 
                              p_buttons_colum, 
                              p_reply_markup); 
 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/editMessageText', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => p_chat_id, v_metod => 'editMessage'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'editmessage', 
                v_err_msg 
            ); 
 
    END editmessage;  
  
    -- удальть сообщение --  
                    PROCEDURE deletemessage ( 
        p_chat_id     INT DEFAULT in_chat_id, 
        p_message_id  INT DEFAULT in_message_id 
    ) AS 
        v_result  CLOB; 
        v_body    CLOB; 
    BEGIN 
        apex_json.initialize_clob_output; 
        apex_json.open_object; 
        apex_json.write('chat_id', p_chat_id); 
        apex_json.write('message_id', p_message_id); 
        apex_json.close_object; 
        v_body := apex_json.get_clob_output; 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/deleteMessage', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => p_chat_id, v_metod => 'deleteMessage'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'deleteMessage', 
                v_err_msg 
            ); 
 
    END deletemessage;  
  
    -------------------  
                    PROCEDURE editmessagereplymarkup ( 
        p_chat_id        INT DEFAULT in_chat_id, 
        p_message_id     INT DEFAULT in_message_id, 
        p_buttons_colum  INT DEFAULT 2 
    ) AS 
        v_result  CLOB; 
        v_body    CLOB; 
    BEGIN  
        --        apex_json.initialize_clob_output;  
        --        apex_json.open_object;  
        --        apex_json.write('chat_id',p_chat_id);  
        --        apex_json.write('message_id',p_message_id);  
        --        apex_json.write('reply_markup',p_reply_markup);  
        --        apex_json.close_object;  
        --        v_body := apex_json.get_clob_output;  
                                        v_body := message_body(p_chat_id, p_message_id, NULL, NULL, NULL, 
                              NULL, 
                              p_buttons_colum, 
                              NULL); 
 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/editMessageReplyMarkup', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => p_chat_id, v_metod => 'editMessageReplyMarkup'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'editMessageReplyMarkup', 
                v_err_msg 
            ); 
 
    END editmessagereplymarkup;  
  
    -------------------  
    PROCEDURE answercallbackquery ( 
        p_callback_query_id  IN  INT, 
        p_text               IN  VARCHAR, 
        p_show_alert         IN  BOOLEAN DEFAULT false 
    ) AS 
        v_result  CLOB; 
        v_body    CLOB; 
    BEGIN 
        apex_json.initialize_clob_output; 
        apex_json.open_object; 
        apex_json.write('callback_query_id', p_callback_query_id); 
        apex_json.write('text', p_text); 
        apex_json.write('show_alert', p_show_alert); 
        apex_json.close_object; 
        v_body := apex_json.get_clob_output; 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/answerCallbackQuery', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => NULL, v_metod => 'answerCallbackQuery'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'editMessageReplyMarkup', 
                v_err_msg 
            ); 
 
    END answercallbackquery;  
  
    -------------------  
  
    -- настройка webhook для входящих сообщений --  
    PROCEDURE setwebhook ( 
        p_webhook_url IN VARCHAR 
    ) AS 
        v_result  CLOB; 
        v_body    CLOB; 
    BEGIN  
        -- отправляем запрос --  
                                        apex_json.initialize_clob_output;  
        -- json --  
                                        apex_json.open_object; 
        apex_json.write('url', p_webhook_url 
                               || '/' 
                               || p_token); 
        apex_json.close_object; 
        v_body := apex_json.get_clob_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => 'Send ' 
                                || p_url 
                                || p_token 
                                || '/setWebhook' 
                                || ', resulr:' 
                                || v_body, 
                     v_result => v_result, 
                     v_metod => 'setWebhook request'); 
        END IF; 
 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/setWebhook', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_metod => 'setWebhook'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'setwebhook', 
                v_err_msg 
            ); 
 
    END setwebhook;  
  
    -- разбор входящего сообщения --  
    PROCEDURE in_parse ( 
        p_body CLOB 
    ) AS 
    BEGIN 
        IF p_debug = 1 THEN 
            add_journ(v_body => p_body, v_metod => 'in_parse'); 
        END IF; 
 
        apex_json.parse(p_body);  
        -- проверим callback --  
                                        in_data := apex_json.get_varchar2('callback_query.data'); 
        IF in_data IS NOT NULL THEN 
            in_chat_id := apex_json.get_number(p_path => 'callback_query.message.chat.id'); 
            in_message_id := apex_json.get_number(p_path => 'callback_query.message.message_id'); 
            in_text := apex_json.get_varchar2('callback_query.message.text'); 
            in_callback_query_id := apex_json.get_number(p_path => 'callback_query.id'); 
        ELSE 
            in_chat_id := apex_json.get_number(p_path => 'message.chat.id'); 
            in_message_id := apex_json.get_number(p_path => 'message.message_id'); 
            in_text := apex_json.get_varchar2('message.text'); 
        END IF;  
  
        -- contact --  
            in_vcard := apex_json.get_varchar2('message.contact.vcard'); -- Отправка чужого контакта!!!--  
  
            IF in_vcard IS NULL THEN 
            in_phone_number := clr_phone(apex_json.get_varchar2('message.from.phone_number')); 
            in_first_name := apex_json.get_varchar2('message.from.first_name'); 
            in_last_name := apex_json.get_varchar2('message.from.last_name'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'in_parse', 
                v_err_msg 
            ); 
 
    END in_parse;  
  
    -- проверка пользователя --  
    PROCEDURE check_user ( 
        v_ex OUT NUMBER 
    ) AS 
    BEGIN  
        -- проверка наличия пользователя  --  
                                    SELECT 
            COUNT(*) 
        INTO v_ex 
        FROM 
            bot_users 
        WHERE 
            chat_id = in_chat_id; 
 
        IF v_ex = 0 THEN 
            INSERT INTO bot_users ( 
                chat_id, 
                first_name, 
                last_name, 
                crt 
            ) VALUES ( 
                in_chat_id, 
                in_first_name, 
                in_last_name, 
                sysdate 
            ); 
 
        END IF; 
 
        v_ex := 1; 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'check_user', 
                v_err_msg 
            ); 
 
    END check_user;  
  
    -- сброс счетчика сессий --  
                    PROCEDURE reset_st ( 
        p_chat_id IN INT DEFAULT in_chat_id 
    ) AS 
    BEGIN 
        UPDATE bot_sessions 
        SET 
            st = 0, 
            menu = NULL, 
            text = NULL 
        WHERE 
            chat_id = p_chat_id; 
 
        session_st := 0; 
        session_menu := NULL; 
    END reset_st;  
  
    -- запись сесии --  
                    PROCEDURE save_session ( 
        v_menu  IN  VARCHAR2 DEFAULT NULL, 
        v_st    IN  INT DEFAULT 0 
    ) AS 
        v_ex  INT; 
        r_    bot_sessions%rowtype; 
    BEGIN 
        r_.chat_id := in_chat_id; 
        SELECT 
            COUNT(*) 
        INTO v_ex 
        FROM 
            bot_sessions 
        WHERE 
            chat_id = r_.chat_id;  
  
        ----------------------------------------  
        -- запишем значения сесии --------------  
                                        r_.mdf := current_date; 
        r_.text := in_text; 
        r_.menu := v_menu; 
        r_.st := v_st; 
        IF v_ex = 0 THEN 
            INSERT INTO bot_sessions VALUES r_; 
 
        ELSE 
            UPDATE bot_sessions 
            SET 
                row = r_ 
            WHERE 
                chat_id = r_.chat_id; 
 
        END IF; 
 
        session_st := v_st; 
        session_menu := v_menu; 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'save_session', 
                v_err_msg 
            ); 
 
    END save_session;  
  
    --   получение сесии --  
                    PROCEDURE get_session AS 
        r_ bot_sessions%rowtype; 
    BEGIN 
        SELECT 
            * 
        INTO r_ 
        FROM 
            bot_sessions 
        WHERE 
            chat_id = in_chat_id; 
 
        session_st := r_.st; 
        session_menu := r_.menu; 
        session_text := r_.text; 
    EXCEPTION 
        WHEN OTHERS THEN 
            session_st := NULL; 
            session_menu := NULL; 
            session_text := NULL; 
    END get_session;  
  
    -- авторизация пользователя через телеграм --  
                    PROCEDURE auth_pin ( 
        v_username IN VARCHAR2 
    ) AS 
        v_pin  VARCHAR2(10); 
        r_     bot_users%rowtype; 
    BEGIN 
        v_pin := round(dbms_random.value(1000, 9999), 0);  
  
        ---  
                                        SELECT 
            * 
        INTO r_ 
        FROM 
            bot_users 
        WHERE 
            upper(login) = upper(v_username); 
 
        UPDATE bot_users 
        SET 
            pin = v_pin, 
            mdf = current_date 
        WHERE 
            upper(login) = upper(v_username);  
  
  
        ---  
                                        sendmessage(p_chat_id => r_.chat_id, p_text => v_pin); 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'auth_pin', 
                v_username 
                || ': ' 
                || v_err_msg 
            ); 
 
    END auth_pin;  
  
    -- сообщение о входе в приложение --  
                    PROCEDURE auth_reg ( 
        v_username  IN  VARCHAR2, 
        v_app_name  IN  VARCHAR2 
    ) AS 
        r_ bot_users%rowtype; 
    BEGIN 
        SELECT 
            * 
        INTO r_ 
        FROM 
            bot_users 
        WHERE 
            upper(login) = upper(v_username); 
 
        UPDATE bot_users 
        SET 
            pin = NULL, 
            mdf = current_date 
        WHERE 
            upper(login) = upper(v_username); 
 
        sendmessage(p_chat_id => r_.chat_id, p_text => 'Вхід у додаток ' 
                                                       || v_app_name 
                                                       || ' - ' 
                                                       || to_char(current_date, 'dd.mm.yyyy hh24:mi:ss')); 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'auth_reg', 
                v_err_msg 
            ); 
 
    END auth_reg; 
 
    PROCEDURE sendimg ( 
        p_chat_id     INT DEFAULT in_chat_id, 
        p_img_id      IN  INT DEFAULT NULL, 
        p_img_url     IN  VARCHAR2 DEFAULT NULL, 
        p_text        IN  CLOB, 
        p_parse_mode  IN  VARCHAR DEFAULT 'HTML' 
    ) AS 
        v_body       CLOB; 
        v_result     CLOB; 
        v_photo_url  VARCHAR2(255); 
    BEGIN 
        IF p_img_id IS NOT NULL THEN 
            v_photo_url := frest_url 
                           || '/img/' 
                           || p_img_id; 
        ELSE 
            v_photo_url := p_img_url; 
        END IF; 
 
        apex_json.initialize_clob_output; 
        apex_json.open_object; 
        apex_json.write('chat_id', p_chat_id); 
        apex_json.write('photo', v_photo_url); 
        apex_json.write('caption', p_text); 
        apex_json.write('parse_mode', p_parse_mode); 
        apex_json.close_object; 
        v_body := apex_json.get_clob_output; 
        apex_web_service.g_request_headers(1).name := 'Content-Type'; 
        apex_web_service.g_request_headers(1).value := 'application/json'; 
        v_result := apex_web_service.make_rest_request(p_url => p_url 
                                                                || p_token 
                                                                || '/sendPhoto', 
                                                      p_http_method => 'POST', 
                                                      p_body => v_body); 
 
        apex_json.free_output; 
        IF p_debug = 1 THEN 
            add_journ(v_body => v_body, v_result => v_result, v_chat_id => p_chat_id, v_metod => 'sendPhoto'); 
        END IF; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
            v_err_msg := sqlerrm; 
            INSERT INTO bot_err_journ ( 
                crt, 
                metod, 
                err_msg 
            ) VALUES ( 
                current_date, 
                'sendmessage', 
                v_err_msg 
            ); 
 
    END sendimg; 
 
END telegram; 
/

