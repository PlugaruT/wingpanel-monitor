project('com.github.plugarut.wingpanel-monitor', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

add_project_arguments(['--vapidir', join_paths(meson.current_source_dir(), 'vapi')], language: 'vala')
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Toggles.vala',
    dependencies: [
        dependency('gee-0.8'),
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('libgtop-2.0'),
        dependency('wingpanel-2.0'),
        meson.get_compiler('c').find_library('m', required : false)
    ],
    install: true
)

subdir('data')
meson.add_install_script('meson/post_install.py')
