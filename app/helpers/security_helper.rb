module SecurityHelper

  def get_permission_name(controller_name, action_name)
    if controller_name.nil? || (controller_name.strip == "") || action_name.nil? || (action_name.strip == "")
      return ""
    else
      return controller_name.downcase + ' # ' + action_name.downcase
    end  
  end

  def check_access_ex(permission_key, controller_name, action_name)
    res = false
    unless current_vendor.blank? 
      res = current_vendor.has_role? :admin
      if !res
        if controller_name.nil? || (controller_name.strip == "")
          contrlr_name = params[:controller]
        else
          contrlr_name = controller_name
        end  
        if action_name.nil? || (action_name.strip == "")
          actn_name = params[:action]
        else
          actn_name = action_name  
        end  
        if permission_key.blank?
          p_name = get_permission_name(contrlr_name, actn_name)
          p = Permission.where("(name = '#{p_name}') and (updated_at is not null)")      
        else
          p = Permission.where("(key = '#{permission_key}') and (updated_at is not null)")
        end
        permission = (p.blank?)?nil:p[0].key
        res = permission.nil? || (@current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true)
        if !res && permission_key.nil?  
           p_name = get_permission_name(contrlr_name, "all")
           p = Permission.where("(name = '#{p_name}') and (updated_at is not null)")   
           permission = (p.blank?)?nil:p[0].key
           res = !(permission.nil?) && (@current_vendor.roles.map { |r| r.has_permission?(permission) }.include? true)
        end  
      end
    end
    return res  
  end    

  def has_access
    return check_access_ex(nil, nil, nil)
  end  

  def check_access
    vendor_not_authorized if !has_access
  end

  def has_access_key(permission_key)
    return check_access_ex(permission_key, nil, nil)
  end 

  def check_access_key(permission_key)
    vendor_not_authorized if !has_access_key(permission_key)
  end 

  def has_access_action(action_name)
    return check_access_ex(nil, nil, action_name)
  end

  def check_access_action(action_name)
    vendor_not_authorized if !has_access_action(action_name)
  end  

  def has_access_controller_action(controller_name, action_name)
    return check_access_ex(nil, controller_name, action_name)
  end

  def has_access_controller(controller_name)
    res = false
    unless current_vendor.blank? 
      res = current_vendor.has_role? :admin
      if !res
        if controller_name.nil? || (controller_name.strip == "")
          contrlr_name = params[:controller]
        else
          contrlr_name = controller_name
        end  
        actn_name = "any_action"
        p_name = get_permission_name(contrlr_name, actn_name).gsub(actn_name, "")
        all_p = Permission.where("(name like '%#{p_name}%') and (updated_at is not null)") 
        unless all_p.blank?          
          all_p.map do |p|
            while !res do  
              @current_vendor.roles.map do |r|
                res = res || (r.has_permission?p.key)
              end  
            end
          end
        else
          res = true    
        end 
      end
    end
    return res 
  end

end
