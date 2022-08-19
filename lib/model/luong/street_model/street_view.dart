import 'package:flutter/material.dart';


mixin StreetsView {
  Map<String, dynamic> getView() {
    return {
      'edit_view':{
        'fields':[
          {
            'field':'code',
            'label':'Mã đường',
            'type':'text_field',
            'span':12,
            'required':true,
            'readOnly':true
          },
          {
            'field':'name',
            'label':'Tên đường',
            'type':'text_field',
            'span':12,
          },
        ],
      },
      'list_view':{
        'fields':[
          {
            'field':'code',
            'label':'Mã đường',
            'type':'text_field',
          },
          {
            'field':'name',
            'label':'Tên đường',
            'type':'text_field',
          },
          {
            'field':'userName',
            'label':'Người quản lý',
            'type':'text_field',
          },
          {
            'field':'action_button',
            'label':'Thao tác',
            'type':'multiple_button',
            'action':[
              {
                'type':'edit',
                'label':'Sửa',
                'icon':Icons.edit
              },
              {
                'type':'delete',
                'label':'Xóa',
                'icon':Icons.delete
              },
            ]
          },
        ],
        'buttons':[
          {
            'type':'create',
            'label':'Tạo',
            'icon':Icons.add
          },
          {
            'type':'import',
            'label':'Nhập',
            'icon':Icons.upload_file
          },
          {
            'type':'export',
            'label':'Xuất',
            'icon':Icons.download_outlined
          },
        ],
        'show_search':false,
        'field_filter':[
        ]
      }
    };
  }
}