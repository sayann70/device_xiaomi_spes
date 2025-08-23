package co.aospa.settings.flashlight;

import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;

import co.aospa.settings.utils.FileUtils;

public class FlashlightTileService extends TileService {

    private static final String TORCH_BRIGHTNESS_NODE = "/sys/class/leds/led:torch/brightness";
    private static final String VALUE_ON = "49";
    private static final String VALUE_OFF = "0";

    @Override
    public void onStartListening() {
        super.onStartListening();
        updateTileState();
    }

    @Override
    public void onClick() {
        super.onClick();
        boolean isEnabled = isFlashlightOn();
        FileUtils.writeLine(TORCH_BRIGHTNESS_NODE, isEnabled ? VALUE_OFF : VALUE_ON);
        updateTileState();
    }

    private void updateTileState() {
        boolean isEnabled = isFlashlightOn();
        Tile tile = getQsTile();
        tile.setState(isEnabled ? Tile.STATE_ACTIVE : Tile.STATE_INACTIVE);
        tile.updateTile();
    }

    private boolean isFlashlightOn() {
        String value = FileUtils.readOneLine(TORCH_BRIGHTNESS_NODE);
        return value != null && !value.equals("0");
    }
}
