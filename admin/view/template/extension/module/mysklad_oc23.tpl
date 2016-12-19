<?php echo $header; ?><?php echo $column_left;
ini_set('display_errors',1);
error_reporting(E_ALL ^E_NOTICE);
#@TODO надо сверстать правильно эту страницу по примеру,а то исправлять чужой код это жесть

?>
<script type="text/javascript" src="view/javascript/jquery/tabs.js"></script>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </div>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>

    <div class="box">
      <div class="left"></div>
      <div class="right"></div>
      <div class="heading">
        <h1 style="background-image: url('view/image/feed.png') no-repeat;"><?php echo $heading_title; ?></h1>
        <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
      </div>
      <div class="content">
        <div id="tabs" class="htabs">
          <a href="#tab-general"><?php echo $text_tab_general; ?></a>
          <a href="#tab-product"><?php echo $text_tab_product; ?></a>
          <a href="#tab-order"><?php echo $text_tab_order; ?></a>
          <a href="#tab-manual"><?php echo $text_tab_manual; ?></a>
        </div>


        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

          <div id="tab-general">
            <table class="form">
              <tr>
                <td><?php echo $entry_username; ?></td>
                <td><input name="mysklad_oc23_username" type="text" value="<?php echo $mysklad_oc23_username; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_password; ?></td>
                <td><input name="mysklad_oc23_password" type="password" value="<?php echo $mysklad_oc23_password; ?>" /></td>
              </tr>

              <tr>
                <td><?php echo $entry_status; ?></td>
                <td><select name="mysklad_oc23_status">
                    <?php if ($mysklad_oc23_status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select></td>
              </tr>

              <tr>
                <td><?php echo $entry_allow_ip; ?></td>
                <td>
                  <textarea name="mysklad_oc23_allow_ip" style="width: 200px; height: 50px;"><?php echo $mysklad_oc23_allow_ip; ?></textarea>
                </td>
              </tr>
            </table>
          </div>

          <div id="tab-product">

            <table id="mysklad_oc23_price_type_id" class="list" style="width: auto">
              <thead>
              <tr>
                <td class="left"><?php echo $entry_config_price_type; ?></td>
                <td class="left"><?php echo $entry_customer_group; ?></td>
                <td class="right"><?php echo $entry_quantity; ?></td>
                <td class="right"><?php echo $entry_priority; ?></td>
                <td></td>
              </tr>
              </thead>
              <tbody>
              <?php $price_row = 0; ?>
              <?php foreach ($mysklad_oc23_price_type as $obj) { ?>
              <?php if ($price_row == 0) { ?>
              <tr id="mysklad_oc23_price_type_row<?php echo $price_row; ?>">
                <td class="left"><input type="text" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                <td class="left"><?php  echo $text_price_default; ?><input type="hidden" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][customer_group_id]" value="0" /></td>
                <td class="center">-<input type="hidden" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][quantity]" value="0" /></td>
                <td class="center">-<input type="hidden" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][priority]" value="0" /></td>
                <td class="left">&nbsp;</td>
              </tr>
              <?php } else { ?>
              <tr id="mysklad_oc23_price_type_row<?php echo $price_row; ?>">
                <td class="left"><input type="text" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][keyword]" value="<?php echo $obj['keyword']; ?>" /></td>
                <td class="left"><select name="mysklad_oc23_price_type[<?php echo $price_row; ?>][customer_group_id]">
                    <?php foreach ($customer_groups as $customer_group) { ?>
                    <?php if ($customer_group['customer_group_id'] == $obj['customer_group_id']) { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select></td>
                <td class="center"><input type="text" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][quantity]" value="<?php echo $obj['quantity']; ?>" size="2" /></td>
                <td class="center"><input type="text" name="mysklad_oc23_price_type[<?php echo $price_row; ?>][priority]" value="<?php echo $obj['priority']; ?>" size="2" /></td>
                <td class="center"><a onclick="$('#mysklad_oc23_price_type_row<?php echo $price_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
              </tr>
              <?php } ?>
              <?php $price_row++; ?>
              <?php } ?>
              </tbody>
              <tfoot>
              <tr>
                <td colspan="4"></td>
                <td class="left"><a onclick="addConfigPriceType();" class="button"><?php echo $button_insert; ?></a></td>
              </tr>
              </tfoot>
            </table>

            <table class="form">
              <tr>
                <td><label for="mysklad_oc23_flush_product"><?php echo $entry_flush_product; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_flush_product" name="mysklad_oc23_flush_product" <?php echo ($mysklad_oc23_flush_product == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_flush_category"><?php echo $entry_flush_category; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_flush_category" name="mysklad_oc23_flush_category" <?php echo ($mysklad_oc23_flush_category == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_flush_manufacturer"><?php echo $entry_flush_manufacturer; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_flush_manufacturer" name="mysklad_oc23_flush_manufacturer" <?php echo ($mysklad_oc23_flush_manufacturer == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_flush_attribute"><?php echo $entry_flush_attribute; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_flush_attribute" name="mysklad_oc23_flush_attribute" <?php echo ($mysklad_oc23_flush_attribute == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_flush_quantity"><?php echo $entry_flush_quantity; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_flush_quantity" name="mysklad_oc23_flush_quantity" <?php echo ($mysklad_oc23_flush_quantity == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_fill_parent_cats"><?php echo $entry_fill_parent_cats; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_fill_parent_cats" name="mysklad_oc23_fill_parent_cats" <?php echo ($mysklad_oc23_fill_parent_cats == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_seo_url"><?php echo $entry_seo_url; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_seo_url" name="mysklad_oc23_seo_url" <?php echo ($mysklad_oc23_seo_url == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_relatedoptions"><?php echo $entry_relatedoptions; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_relatedoptions" name="mysklad_oc23_relatedoptions" <?php echo ($mysklad_oc23_relatedoptions == 1)? 'checked' : ''; ?>>
                  <span class="help"><?php echo $entry_relatedoptions_help; ?></span>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_full_log"><?php echo $entry_full_log; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_full_log" name="mysklad_oc23_full_log" <?php echo ($mysklad_oc23_full_log == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_apply_watermark"><?php echo $entry_apply_watermark; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_apply_watermark" name="mysklad_oc23_apply_watermark" <?php echo ($mysklad_oc23_apply_watermark == 1)? 'checked' : ''; ?>>
                  <div class="image"><img src="<?php echo $thumb; ?>" alt="" id="thumb" />
                    <input type="hidden" name="mysklad_oc23_watermark" value="<?php echo $mysklad_oc23_watermark; ?>" id="image" />
                    <br /><a onclick="image_upload('image', 'thumb');">
                      <?php echo $text_browse; ?>
                    </a>
                    &nbsp;&nbsp;|&nbsp;&nbsp;
                    <a onclick="$('#thumb').attr('src', '<?php echo $no_image; ?>'); $('#image').attr('value', '');">
                      <?php echo $text_clear; ?>
                    </a>
                  </div>
                  <?php if ($error_image) { ?>
                  <span class="error"><?php echo $error_image; ?></span>
                  <?php } ?>
                </td>
              </tr>
            </table>
          </div>

          <div id="tab-order">
            <table class="form">

              <tr>
                <td><?php echo $entry_order_status_to_exchange; ?></td>
                <td>
                  <select name="mysklad_oc23_order_status_to_exchange">
                    <option value="0" <?php echo ($mysklad_oc23_order_status_to_exchange == 0)? 'selected' : '' ;?>><?php echo $entry_order_status_to_exchange_not; ?></option>
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <option value="<?php echo $order_status['order_status_id'];?>" <?php echo ($mysklad_oc23_order_status_to_exchange == $order_status['order_status_id'])? 'selected' : '' ;?>><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <tr>
                <td><?php echo $entry_order_status; ?></td>
                <td>
                  <select name="mysklad_oc23_order_status">
                    <?php foreach ($order_statuses as $order_status) { ?>
                    <option value="<?php echo $order_status['order_status_id'];?>" <?php echo ($mysklad_oc23_order_status == $order_status['order_status_id'])? 'selected' : '' ;?>><?php echo $order_status['name']; ?></option>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_order_currency"><?php echo $entry_order_currency; ?></label></td>
                <td>
                  <input type="text" name="mysklad_oc23_order_currency" value="<?php echo $mysklad_oc23_order_currency; ?>">
                </td>
              </tr>

              <tr>
                <td><label for="mysklad_oc23_order_notify"><?php echo $entry_order_notify; ?></label></td>
                <td>
                  <input type="checkbox" value="1" id="mysklad_oc23_order_notify" name="mysklad_oc23_order_notify" <?php echo ($mysklad_oc23_order_notify == 1)? 'checked' : ''; ?>>
                </td>
              </tr>

            </table>
          </div>

          <div id="tab-manual">
            <table class="form">
              <tr>
                <td>
                  <?php echo $entry_upload; ?>
                </td>
                <td>
                  <a id="button-upload" class="button"><?php echo $button_upload; ?></a>
                </td>
                <td>
                  <?php echo $text_max_filesize; ?>
                </td>
              </tr>
            </table>
          </div>

        </form>

      </div>

      <div style="text-align:center; opacity: .5">
        <p><?php echo $version; ?> | <a href="http://zenwalker.ru/lab/opencart-mysklad_oc23"><?php echo $text_homepage; ?></a></p>
      </div>
    </div>
  </div>


  <script type="text/javascript"><!--
    $('#tabs a').tabs();
    //--></script>

  <script type="text/javascript" src="view/javascript/jquery/ajaxupload.js"></script>
  <script type="text/javascript"><!--
    new AjaxUpload('#button-upload', {
      action: 'index.php?route=module/mysklad_oc23/manualImport&token=<?php echo $token; ?>',
      name: 'file',
      autoSubmit: true,
      responseType: 'json',
      onSubmit: function(file, extension) {
        $('#button-upload').after('<img src="view/image/loading.gif" class="loading" style="padding-left: 5px;" />');
        $('#button-upload').attr('disabled', true);
      },
      onComplete: function(file, json) {
        $('#button-upload').attr('disabled', false);
        $('.loading').remove();

        if (json['success']) {
          alert(json['success']);
        }

        if (json['error']) {
          alert(json['error']);
        }
      }
    });
    //--></script>
  <script type="text/javascript"><!--
    var price_row = <?php echo $price_row; ?>;


    //--></script>
  <script type="text/javascript"><!--
    function image_upload(field, thumb) {
      $('#dialog').remove();

      $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

      $('#dialog').dialog({
        title: '<?php echo $text_image_manager; ?>',
        close: function (event, ui) {
          if ($('#' + field).attr('value')) {
            $.ajax({
              url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).val()),
              dataType: 'text',
              success: function(data) {
                $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
              }
            });
          }
        },
        bgiframe: false,
        width: 800,
        height: 400,
        resizable: false,
        modal: false
      });
    };
    //--></script>

  <?php echo $footer; ?>