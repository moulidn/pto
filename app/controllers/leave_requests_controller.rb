class LeaveRequestsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
  @pto = PtoRequest.new
  @emp_name = Employee.all.pluck(:emp_name,:emp_no)
    # p @emp_name
  end

  def create
    @pto_dates = PtoRequest.new(pto_date_params)
    from_date=Date.strptime(params[:pto_request][:from_date], '%d/%m/%Y')
    to_date=Date.strptime(params[:pto_request][:to_date], '%d/%m/%Y')
    tot_dates = (from_date..to_date).to_a.map{|x| DateTime.parse(x.to_s).strftime("%d/%m/%Y")}
    from_duration = params[:pto_request][:from_duration]
    to_duration = params[:pto_request][:to_duration]
    emp_name =  Employee.where(:emp_no => params[:pto_request][:emp_no]).pluck(:emp_name).first

    if(from_date == to_date)
      if(params[:pto_request][:from_duration] =="Session 1")
        duration = "1st Half"
      elsif(params[:pto_request][:from_duration] =="Full Day")
        duration = "Full Day";
      else
        duration = "2nd Half";
      end
      PtoRequest.create(:pto_date=>tot_dates.first,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>duration)
    else
    if(from_duration =="Session 1" && to_duration =="Session 1" )
      tot_dates.each { |x|
        if(tot_dates.last == x)
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"1st Half")
        else
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"Full")
        end
      }
    end
    if(from_duration =="Session 1" && to_duration =="Session 2" )
      tot_dates.each { |x|
        if(tot_dates.last == x)
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"Full")
        else
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"Full")
        end
      }
    end
    if(from_duration =="Session 2" && to_duration =="Session 1" )
      tot_dates.each { |x|
        if(tot_dates.last == x)
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"1st Half")
        else
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"2nd Half")
        end
      }
    end
    if(from_duration =="Session 2" && to_duration =="Session 2" )
      tot_dates.each { |x|
        if(tot_dates.last == x)
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"Full")
        else
          PtoRequest.create(:pto_date=>x,:emp_no=>params[:pto_request][:emp_no],:Emp_Name=>emp_name,:leave_type=>params[:pto_request][:leave_type],:leave_duration=>"2nd Half")
        end
      }
    end
    end
      render "view"
  end

  def show
   @pto_date = PtoRequest.all
  end

  def search_leave
    @pto ="";
    if ( params[:emp_name] == nil && params[:emp_id] == nil && params[:pto_dt] == nil)
      @emp_name =  PtoRequest.all.distinct.pluck(:Emp_Name)
      @pto_date = PtoRequest.all
    else
      @emp_name =  PtoRequest.all.distinct.pluck(:Emp_Name)
      p = {
          :Emp_Name => params[:emp_name],
          :emp_no => params[:emp_id],
          :pto_date => params[:pto_dt],
      }
      p.reject!{|b,a| a.nil? or a.eql?"" }
      @pto_date = PtoRequest.where(p)
    end
  end

  def delete_leave
    @pto ="";
    if ( params[:emp_name] == nil && params[:emp_id] == nil && params[:pto_dt] == nil)
      @emp_name =  PtoRequest.all.distinct.pluck(:Emp_Name)
      @pto_date = PtoRequest.all
    else
      @emp_name =  PtoRequest.all.distinct.pluck(:Emp_Name)
      p = {
          :Emp_Name => params[:emp_name],
          :emp_no => params[:emp_id],
          :pto_date => params[:pto_dt],
      }
      p.reject!{|b,a| a.nil? or a.eql?"" }
      @pto_date = PtoRequest.where(p)
    end
  end

  def leave_delete
    @leave = PtoRequest.where(:id=>params[:leave_id]).first.delete
    respond_to do |format|
      format.js {render js: "window.location = '#{delete_leave_leave_requests_path}';", notice: 'Leave was successfully deleted.'}
    end
  end

  def pto_date_params
    params.require(:pto_request).permit(:emp_no, :from_date,:to_date,:leave_type,:Leave_duration)
  end
end
