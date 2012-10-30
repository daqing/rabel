if [ -z "$1" -o -z "$2" ]; then
  echo -e "\033[1;31mUSAGE: $0 [symlink] [new_version]\033[0m"
  echo -e "\033[1;32m--- doc ---:"
  echo -e "symlink:\t symbol link path to current version"
  echo -e "new_version:\t new version to upgrade"
  echo -e "--- example ---:"
  echo -e "$0 ~/sites/rabel 1392"
  echo -en "\033[0m"
  exit
fi

BASH=`which bash`
CURRENT_VERSION_DIR="$1"
NEW_VERSION="$2"
NEW_VERSION_FILE="~/software/rabel-$NEW_VERSION.zip"
DEPLOY_DIR=`dirname $CURRENT_VERSION_DIR`
SITE_ID=`basename $CURRENT_VERSION_DIR`

function show_step {
  echo "\033[1;35mNEXT STEP:\t$1\033[0m"
}

new_deploy_dir="$DEPLOY_DIR/$SITE_ID-$NEW_VERSION"
show_step "create dir: $new_deploy_dir"
mkdir $new_deploy_dir

show_step "cd: $new_deploy_dir"
cd $new_deploy_dir
show_step "unzip: $NEW_VERSION_FILE"
unzip $NEW_VERSION_FILE
show_step "install budnle"
$BASH ./deploy/install_bundle.sh
show_step "copy previous settings"
cp $CURRENT_VERSION_DIR/config/setttings.yml ./config/
show_step "copy previous db settings"
cp $CURRENT_VERSION_DIR/config/database.yml ./config/
show_step "migrate database"
$BASH ./deploy/migrate_database.sh
show_step "precompile assets"
$BASH ./deploy/precompile_assets.sh
show_step "copy uploaded files"
cp -R $CURRENT_VERSION_DIR/public/uploads/* ./public/uploads/

# ready to deploy
show_step "stop thin servers"
sudo service thin stop
sudo service memcached stop

show_step "create new symlink"
rm $CURRENT_VERSION_DIR
ln -s $new_deploy_dir $CURRENT_VERSION_DIR

show_step "start thin servers"
sudo service thin start
sudo service memcached start

show_step "reload nginx"
sudo nginx -s reload

