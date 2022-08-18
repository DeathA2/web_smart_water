
import 'package:flutter/material.dart';
mixin AdminHistoryView {
  Map<String, dynamic> getView() {
    return {
      'edit_view':{
        'fields':[
          {
            'field':'username',
            'label':'username',
            'type':'text_field',
            'span':12,
            'required':true,
            'readOnly':true
          },
          {
            'field':'idkh',
            'label':'ID khách hàng',
            'type':'text_field',
            'span':12,
            'readOnly':true
          },
          {
            'field':'tenkh',
            'label':'Tên khách hàng',
            'type':'text_field',
            'span':12,
            'readOnly':true
          },
          {
            'field':'diachi',
            'label':'Địa chỉ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'madp',
            'label':'Mã đường',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'tendp',
            'label':'Tên đường',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'type',
            'label':'Loại',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'createdTime',
            'label':'Thời gian tạo',
            'type':'text_field',
            'span':12,
          },
        ],
      },
      'list_view':{
        'fields':[
          {
            'field':'username',
            'label':'username',
            'type':'text_field',
          },
          {
            'field':'idkh',
            'label':'ID khách hàng',
            'type':'text_field',
          },
          {
            'field':'tenkh',
            'label':'Tên khách hàng',
            'type':'text_field',
          },
          {
            'field':'diachi',
            'label':'Địa chỉ',
            'type':'text_field',
          },
          {
            'field':'madp',
            'label':'Mã đường',
            'type':'text_field',
          },
          {
            'field':'tendp',
            'label':'Tên đường',
            'type':'text_field',
          },
          {
            'field':'type',
            'label':'Loại',
            'type':'text_field',
          },
          {
            'field':'createdTime',
            'label':'Thời gian tạo',
            'type':'text_field',
          },
        ],
        'buttons':[
        ],
        'show_search':false,
        'field_filter':[
        ]
      }
    };
  }
}