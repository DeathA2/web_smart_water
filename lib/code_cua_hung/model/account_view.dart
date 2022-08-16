
import 'package:flutter/material.dart';
mixin AccountView {
  Map<String, dynamic> getView() {
    return {
      'edit_view':{
        'fields':[
          {
            'field':'user',
            'label':'Tên',
            'type':'text_field',
            'span':12,
            'required':true,
            'readOnly':true
          },
          {
            'field':'username',
            'label':'Tài khoản',
            'type':'text_field',
            'span':12,
            'readOnly':true
          },
          {
            'field':'password',
            'label':'Mật khẩu',
            'type':'text_field',
            'span':12,
            'readOnly':true
          },
          {
            'field':'des',
            'label':'Mô tả',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'role',
            'label':'Vai trò',
            'type':'dropdown',
            'span':12,
            'list_string':'role_account'
          },
        ],
      },
      'list_view':{
        'fields':[
          {
            'field':'user',
            'label':'Tên',
            'type':'text_field',
          },
          {
            'field':'username',
            'label':'Tài khoản',
            'type':'text_field',
          },
          {
            'field':'des',
            'label':'Mô tả',
            'type':'text_field',
          },
          {
            'field':'role',
            'label':'Vai trò',
            'type':'dropdown',
            'list_string': 'role_account',
          },
          {
            'field':'action_button',
            'label':'Action',
            'type':'multiple_button',
            'action':[
              {
                'type':'edit',
                'label':'Edit',
                'icon':Icons.edit
              },
              {
                'type':'delete',
                'label':'Delete',
                'icon':Icons.delete
              },
            ]
          },
        ],
        'buttons':[
          {
            'type':'create',
            'label':'Create',
            'icon':Icons.add
          }
        ],
        'show_search':false,
        'field_filter':[
        ]
      }
    };
  }
}