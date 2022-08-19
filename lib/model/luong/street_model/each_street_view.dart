import 'package:flutter/material.dart';


mixin CustomerEachStreetView {
  Map<String, dynamic> getView() {
    return {
      'edit_view':{
        'fields':[
          {
            'field':'idkh',
            'label':'ID khách hàng',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'danhbo',
            'label':'Danh bộ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'sdt',
            'label':'Số điện thoại',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'tenkh',
            'label':'Tên khách hàng',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'diachi',
            'label':'Địa chỉ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'loaigia',
            'label':'Loại giá',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'serialmodule',
            'label':'Serial Module',
            'type':'text_field',
            'span':6,
          },
          {
            'field':'serialdh',
            'label':'Serial Đồng hồ',
            'type':'text_field',
            'span':6,
          },
          {
            'field':'hieudh',
            'label':'Hiệu đồng hồ',
            'type':'text_field',
            'span':6,
          },
          {
            'field':'kichcodh',
            'label':'Kích cỡ đồng hồ',
            'type':'text_field',
            'span':6,
          },
          {
            'field':'vitridh',
            'label':'Vị trí đồng hồ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'longitude',
            'label':'Kinh độ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'latitude',
            'label':'Vĩ độ',
            'type':'text_field',
            'span':12,
          },
          {
            'field':'sonk',
            'label':'Số nk',
            'type':'text_field',
            'span':12,
          },
        ],
      },
      'list_view':{
        'fields':[
          {
            'field':'stt',
            'label':'STT',
            'type':'text_field',
          },
          {
            'field':'idkh',
            'label':'ID khách hàng',
            'type':'text_field',
          },
          {
            'field':'danhbo',
            'label':'Danh bộ',
            'type':'text_field',
          },
          {
            'field':'sdt',
            'label':'Số điện thoại',
            'type':'text_field',
          },
          {
            'field':'tenkh',
            'label':'Tên khách hàng',
            'type':'text_field',
          },
          {
            'field':'latitude',
            'label':'Vĩ độ',
            'type':'text_field',
          },
          {
            'field':'longitude',
            'label':'Kinh độ',
            'type':'text_field',
          },
          {
            'field':'action_button',
            'label':'Thao tác',
            'type':'multiple_button',
            'action':[
              {
                'type':'detail',
                'label':'Chi tiết',
                'icon':Icons.remove_red_eye
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
          // {
          //   'type':'create',
          //   'label':'Tạo',
          //   'icon':Icons.add
          // }
        ],
        'show_search':false,
        'field_filter':[
        ]
      }
    };
  }
}