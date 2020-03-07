/*-
 * Copyright (c) 2020 Tudor Plugaru (https://github.com/PlugaruT/wingpanel-monitor)
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
 */

namespace WingpanelMonitor {
    public class MainWindow : Gtk.Window {
        private GLib.Settings settings;
        private GWeather.Location location;
        private GWeather.Info weather_info;

        public MainWindow (Gtk.Application application) {
            Object (
                application: application,
                border_width: 1,
                icon_name: "com.github.plugarut.wingpanel-monitor",
                resizable: false, title: "Wingpanel Monitor",
                window_position: Gtk.WindowPosition.CENTER,
                default_width: 300
                );
        }

        construct {
            settings = new GLib.Settings ("com.github.plugarut.wingpanel-monitor");
            var toggles = new TogglesWidget (settings);

            get_location.begin ();
            
            weather_info = new GWeather.Info (location);

            var refresh_btn = new Gtk.Button.from_icon_name ("view-refresh-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            refresh_btn.tooltip_text = "Refresh weather";
            refresh_btn.clicked.connect(()=> {
                weather_info.update ();
            });

            var layout = new Gtk.Grid ();
            layout.hexpand = true;
            layout.margin = 10;
            layout.column_spacing = 6;
            layout.row_spacing = 10;

            layout.attach (toggles, 0, 1, 1, 1);

            var header = new Gtk.HeaderBar ();
            header.show_close_button = true;
            header.pack_end(refresh_btn);

            var header_context = header.get_style_context ();
            header_context.add_class ("titlebar");
            header_context.add_class ("default-decoration");
            header_context.add_class (Gtk.STYLE_CLASS_FLAT);

            set_titlebar (header);
            add (layout);
            
            focus_in_event.connect (() => {
                weather_info.update ();
            });
            
            settings.changed["weather-refresh"].connect(()=>{
                weather_info.update ();
            });

            weather_info.updated.connect(() => {
                if (location == null) {
                    return;
                }
                double temp;
                weather_info.get_value_temp (GWeather.TemperatureUnit.DEFAULT, out temp);
                int t = (int) temp;
                settings.set_string("weather-temperature", "%s°".printf(t.to_string()));
                settings.set_string("weather-icon", weather_info.get_symbolic_icon_name ());
                settings.set_string("weather-location", dgettext("libgweather-locations", location.get_city_name ()));
            });
            
        }
        
        public async void get_location () {
            try {
                var simple = yield new GClue.Simple ("com.github.plugarut.wingpanel-monitor", GClue.AccuracyLevel.CITY, null);
    
                simple.notify["location"].connect (() => {
                    on_location_updated (simple.location.latitude, simple.location.longitude);
                });
    
                on_location_updated (simple.location.latitude, simple.location.longitude);
            } catch (Error e) {
                warning ("Failed to connect to GeoClue2 service: %s", e.message);
                return;
            }
        }
        
        public void on_location_updated (double latitude, double longitude) {
            location = GWeather.Location.get_world ();
            location = location.find_nearest_city (latitude, longitude);
            if (location != null) {
                weather_info.location = location;
                weather_info.update ();
            }
        }

    }
}
