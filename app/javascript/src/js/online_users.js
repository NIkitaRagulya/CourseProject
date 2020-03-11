$(document).ready(() => {
  $('.user-checkbox').change(e => {
   

    let allChecked = $('.user-checkbox:checked').length == $('.user-checkbox').length;
    $('#checkall').prop('checked', allChecked);
    
  });
  
  $('#checkall').change(e => {
    $('.user-checkbox').prop('checked', e.target.checked)
  });

  $('#ban_selected_users').click(() => {
    let userIds = $('.user-checkbox:checked').toArray().map(a => a.id);
    $.ajax({
      url: '/online_users/ban_users',
      method: 'put',
      data: {
        user_ids: userIds
      },
      success: (data) => {
        // console.log(data)
        window.location.reload();
      }
    });
  })

  $('#unlock_selected_users').click(() => {
    let userIds = $('.user-checkbox:checked').toArray().map(a => a.id);
    $.ajax({
      url: '/online_users/unlock_users',
      method: 'put',
      data: {
        user_ids: userIds
      },
      success: (data) => {
        // console.log(data)
        window.location.reload();
      }
    });
  })

  $('#delete_selected_users').click(() => {
    let userIds = $('.user-checkbox:checked').toArray().map(a => a.id);
    $.ajax({
      url: '/online_users/delete_users',
      method: 'delete',
      data: {
        user_ids: userIds
      },
      success: (data) => {
        // console.log(data)
        window.location.reload();
      }
    });
  })
});
