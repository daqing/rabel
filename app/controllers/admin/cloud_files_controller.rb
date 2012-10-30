# encoding: utf-8
class Admin::CloudFilesController < Admin::BaseController
  def index
    @title = '云硬盘'
    @files = CloudFile.order('id DESC').page(params[:page])
  end

  def new
    @file = CloudFile.new
    @title = '上传新文件'
  end

  def create
    @file = CloudFile.new(params[:cloud_file])

    if @file.save
      redirect_to admin_cloud_files_path
    else
      @title = '上传新文件'
      render :new
    end
  end

  def destroy
    @file = CloudFile.find(params[:id])

    if @file.destroy
      flash[:success] = '删除成功'
    else
      flash[:error] = '删除失败'
    end
    redirect_to admin_cloud_files_path
  end
end
