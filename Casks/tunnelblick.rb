cask 'tunnelblick' do
    version '3.7.6a,5080'
    sha256 '0607df6686735b9b0abb0b7607f221cd62ad25f2208a02b2680a53121ee07de0'

    # github.com/Tunnelblick/Tunnelblick was verified as official when first introduced to the cask
    url 'https://github.com/Tunnelblick/Tunnelblick/releases/download/v3.5.24/Tunnelblick_3.5.24_build_4270.5031.dmg'
    appcast 'https://github.com/Tunnelblick/Tunnelblick/releases.atom'
    name 'Tunnelblick'
    homepage 'https://www.tunnelblick.net/'
    gpg "#{url}.asc", key_id: '76df975a1c5642774fb09868ff5fd80e6bb9367e'

    auto_updates true

    app 'Tunnelblick.app'

    uninstall_preflight do
        set_ownership "#{appdir}/Tunnelblick.app"
    end

    uninstall launchctl: [
        'net.tunnelblick.tunnelblick.LaunchAtLogin',
        'net.tunnelblick.tunnelblick.tunnelblickd',
    ],
    quit:      'net.tunnelblick.tunnelblick'

    zap trash: [
        '~/Library/Application Support/Tunnelblick',
        '~/Library/Caches/net.tunnelblick.tunnelblick',
        '~/Library/Caches/com.apple.helpd/SDMHelpData/Other/English/HelpSDMIndexFile/Tunnelblick*',
        '~/Library/Cookies/net.tunnelblick.tunnelblick.binarycookies',
        '~/Library/Preferences/net.tunnelblick.tunnelblick.plist',
        '/Library/Application Support/Tunnelblick',
    ]

    caveats <<~EOS
    For security reasons, #{token} must be installed to /Applications,
    and will request to be moved at launch.
    EOS
end
