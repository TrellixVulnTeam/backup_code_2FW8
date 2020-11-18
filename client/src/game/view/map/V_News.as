package game.view.map {
    import com.cong.interfaces.IView;

    import ui.map.NewsUI;

public class V_News extends NewsUI implements IView{
    public function V_News() {
        super();
    }

    private static var _instance:V_News;
    public static function get instance():V_News
    {
        if (null == _instance)
        {
            _instance = new V_News();
        }
        return _instance;
    }


    public function onShow():void
    {
    }

    public function onHide():void
    {
    }

    public function addAllListeners():void
    {
    }

    public function removeAllListeners():void
    {
    }
}
}
