const Sequelize = require("sequelize");
module.exports = function (sequelize, DataTypes) {
  return sequelize.define(
    "username_login_seller",
    {
      run_id: {
        autoIncrement: true,
        type: DataTypes.INTEGER,
        allowNull: false,
        unique: "id",
      },
      username: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: "username",
      },
      phash: {
        type: DataTypes.STRING(32),
        allowNull: false,
      },
      seller_id: {
        type: DataTypes.STRING(10),
        allowNull: false,
        defaultValue: "",
        primaryKey: true,
      },
      subdomain: {
        type: DataTypes.STRING(50),
        allowNull: false,
      },
      package_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      total_number: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      num_viewed: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      viewed: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      picture_path: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      picture_path_new: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      cover_path: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      edit_name: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      first_name: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      last_name: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      id_card: {
        type: DataTypes.STRING(13),
        allowNull: false,
      },
      id_card_path: {
        type: DataTypes.STRING(300),
        allowNull: false,
      },
      edit_detail_seller: {
        type: DataTypes.STRING(200),
        allowNull: false,
      },
      edit_phone: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      line_id: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      facebook: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      twitter: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      instagram: {
        type: DataTypes.STRING(100),
        allowNull: false,
        defaultValue: "",
      },
      edit_email: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      edit_web: {
        type: DataTypes.STRING(100),
        allowNull: false,
      },
      edit_detail_payment: {
        type: DataTypes.STRING(300),
        allowNull: false,
      },
      edit_detail_receive_product: {
        type: DataTypes.STRING(300),
        allowNull: false,
      },
      expired_date: {
        type: DataTypes.DATEONLY,
        allowNull: false,
      },
      expired_time: {
        type: DataTypes.TIME,
        allowNull: false,
      },
      timestamp: {
        type: DataTypes.DATE,
        allowNull: false,
        defaultValue: Sequelize.Sequelize.fn("current_timestamp"),
      },
      address: {
        type: DataTypes.STRING(500),
        allowNull: false,
      },
      province: {
        type: DataTypes.STRING(20),
        allowNull: false,
      },
      status: {
        type: DataTypes.CHAR(1),
        allowNull: false,
        defaultValue: "I",
      },
      hidden: {
        type: DataTypes.CHAR(1),
        allowNull: false,
        defaultValue: "N",
      },
      token: {
        type: DataTypes.STRING(255),
        allowNull: false,
      },
      draft: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      reset: {
        type: DataTypes.CHAR(1),
        allowNull: false,
        defaultValue: "N",
      },
      reset_time: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      certified: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      offer: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      buyberded: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      analysis: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      sort: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      sort_by: {
        type: DataTypes.STRING(20),
        allowNull: false,
        defaultValue: "update_from_max",
      },
      limit: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 30,
      },
      contact_seller_count: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
      },
      count_berded: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
      },
      count_recommend: {
        type: DataTypes.INTEGER,
        allowNull: false,
        defaultValue: 0,
      },
      flag_status_check_exp: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 0,
      },
      seller_note: {
        type: DataTypes.TEXT,
        allowNull: false,
      },
      registration_date: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      update_date: {
        type: DataTypes.DATE,
        allowNull: false,
      },
      tokenAPI: {
        type: DataTypes.STRING(255),
        allowNull: true,
      },
      rating: {
        type: DataTypes.FLOAT,
        allowNull: false,
        defaultValue: 0,
      },
      noti_help: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: 1,
      },
    },
    {
      sequelize,
      tableName: "username_login_seller",
      timestamps: false,
      indexes: [
        {
          name: "PRIMARY",
          unique: true,
          using: "BTREE",
          fields: [{ name: "seller_id" }],
        },
        {
          name: "username",
          unique: true,
          using: "BTREE",
          fields: [{ name: "username" }],
        },
        {
          name: "id",
          unique: true,
          using: "BTREE",
          fields: [{ name: "run_id" }],
        },
        {
          name: "seller_id",
          using: "BTREE",
          fields: [{ name: "seller_id" }],
        },
        {
          name: "expired_date",
          using: "BTREE",
          fields: [{ name: "expired_date" }],
        },
        {
          name: "expired_time",
          using: "BTREE",
          fields: [{ name: "expired_time" }],
        },
        {
          name: "subdomain",
          using: "BTREE",
          fields: [{ name: "subdomain" }],
        },
      ],
    }
  );
};
