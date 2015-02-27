require 'test_helper'

class QiniuImagesControllerTest < ActionController::TestCase
  setup do
    @qiniu_image = qiniu_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:qiniu_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create qiniu_image" do
    assert_difference('QiniuImage.count') do
      post :create, qiniu_image: {  }
    end

    assert_redirected_to qiniu_image_path(assigns(:qiniu_image))
  end

  test "should show qiniu_image" do
    get :show, id: @qiniu_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @qiniu_image
    assert_response :success
  end

  test "should update qiniu_image" do
    patch :update, id: @qiniu_image, qiniu_image: {  }
    assert_redirected_to qiniu_image_path(assigns(:qiniu_image))
  end

  test "should destroy qiniu_image" do
    assert_difference('QiniuImage.count', -1) do
      delete :destroy, id: @qiniu_image
    end

    assert_redirected_to qiniu_images_path
  end
end
