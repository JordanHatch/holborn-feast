module ControllerViewStubHelper
  def stub_view_rendering
    @controller.stubs(:render)
  end
end
