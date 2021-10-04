/*-
 * Copyright (c) 2021 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 *
 * Authored by: Tudor Plugaru <plugaru.tudor@gmail.com>
 *              Anderson Laverde <anderson.laverde@zohomail.com>
 */

public class WingpanelMonitor.TogglesWidget : Gtk.Grid {
    private Granite.SwitchModelButton indicator;
    private Granite.SwitchModelButton cpu_switch;
    private Granite.SwitchModelButton icon_only_switch;
    private Granite.SwitchModelButton ram_switch;
    private Granite.SwitchModelButton network_switch;
    private Granite.SwitchModelButton bits_switch;
    private Granite.SwitchModelButton workspace_switch;
    private Granite.SwitchModelButton weather_switch;
    private SpinRow weather_refresh_spin;
    private Settings settings;

    public TogglesWidget () {
        Object (hexpand: true);
    }

    construct {
        orientation = Gtk.Orientation.VERTICAL;
        settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");
        indicator = new Granite.SwitchModelButton ("ON/OFF") {
            active = settings.get_boolean ("display-indicator"),
            margin_bottom = 5
        };
        cpu_switch = new Granite.SwitchModelButton ("CPU usage") {
            active = settings.get_boolean ("show-cpu"),
            margin_bottom = 5
        };
        icon_only_switch = new Granite.SwitchModelButton ("Show icon") {
            active = settings.get_boolean ("icon-only"),
            margin_bottom = 5
        };
        ram_switch = new Granite.SwitchModelButton ("RAM usage") {
            active = settings.get_boolean ("show-ram"),
            margin_bottom = 5
        };
        network_switch = new Granite.SwitchModelButton ("Network usage") {
            active = settings.get_boolean ("show-network"),
            margin_bottom = 5
        };
        bits_switch = new Granite.SwitchModelButton ("Network usage in bits") {
            active = settings.get_boolean ("show-bits"),
            sensitive = network_switch.active,
            margin_bottom = 5
        };
        workspace_switch = new Granite.SwitchModelButton ("Workspace number") {
            active = settings.get_boolean ("show-workspace"),
            margin_bottom = 5
        };
        var current_location = settings.get_string ("weather-location");
        weather_switch = new Granite.SwitchModelButton ("Weather for %s".printf (current_location)) {
            active = settings.get_boolean ("show-weather"),
            margin_bottom = 5
        };

        indicator.toggled.connect (() => settings.set_boolean ("display-indicator", indicator.get_active ()));
        cpu_switch.toggled.connect (() => settings.set_boolean ("show-cpu", cpu_switch.get_active ()));
        icon_only_switch.toggled.connect (() => settings.set_boolean ("icon-only", icon_only_switch.get_active ()));
        ram_switch.toggled.connect (() => settings.set_boolean ("show-ram", ram_switch.get_active ()));
        network_switch.toggled.connect (() => {
            settings.set_boolean ("show-network", network_switch.get_active ());
            bits_switch.sensitive = network_switch.active;
        });
        bits_switch.toggled.connect (() => settings.set_boolean ("show-bits", bits_switch.get_active ()));
        workspace_switch.toggled.connect (() => settings.set_boolean ("show-workspace", workspace_switch.get_active ()));
        weather_switch.toggled.connect (() => settings.set_boolean ("show-weather", weather_switch.get_active ()));

        weather_refresh_spin = new SpinRow ("Weather refresh rate (min)", 1, 60);
        weather_refresh_spin.set_spin_value (settings.get_int ("weather-refresh-rate"));
        weather_refresh_spin.changed.connect ( () => {
            settings.set_int ("weather-refresh-rate", weather_refresh_spin.get_spin_value ());
        });

        add (indicator);
        add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL) { margin_bottom = 5 });
        add (icon_only_switch);
        add (cpu_switch);
        add (ram_switch);
        add (network_switch);
        add (bits_switch);
        add (workspace_switch);
        add (weather_switch);
        add (new Gtk.Separator (Gtk.Orientation.HORIZONTAL) { margin_bottom = 5 });
        add (weather_refresh_spin);
    }
}
