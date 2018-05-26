require 'wechat/api_base'
require 'wechat/http_client'
require 'wechat/token/public_access_token'
require 'wechat/ticket/public_jsapi_ticket'
require 'wechat/concern/common'

module Wechat
  class MpApi < ApiBase
    include Concern::Common

    def template_message_send(message)
      post 'message/wxopen/template/send', message.to_json, content_type: :json
    end

    def list_template_library(offset: 0, count: 20)
      post 'wxopen/template/library/list', JSON.generate(offset: offset, count: count)
    end

    def list_template_library_words(word_id)
      post 'template/library/get', JSON.generate(id: word_id)
    end

    def add_message_template(template_id, keyword_id_list = [])
      post 'template/add', JSON.generate(id: template_id, keyword_id_list: keyword_id_list)
    end

    def list_message_template(offset = 0, count = 20)
      post 'template/list', JSON.generate(offset: offset, count: count)
    end

    def del_message_template(template_id)
      post 'template/del', JSON.generate(template_id: template_id)
    end

    def login(code)
      params = {
        appid: access_token.appid,
        secret: access_token.secret,
        js_code: code,
        grant_type: 'authorization_code'
      }

      client.get 'jscode2session', params: params, base: OAUTH2_BASE
    end
  end
end
