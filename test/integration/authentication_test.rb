require 'test_helper'

class AuthenticationTest < ActionController::IntegrationTest
  test "sisteme giriş" do
    visit "/"
    fill_in "name", :with => "chpli"
    fill_in "password", :with=> "a"
    click_button "submit"
    assert_contain "Hoşgeldiniz."
  end


  test "kullanıcı adı veya şifre hatası" do
    visit "/"
    fill_in "name", :with => "chpli"
    fill_in "password", :with=> "aasdakd"
    click_button "submit"
    assert_contain "Kullanıcı adı veya şifre yanlış."
  end

  test "Hicbir bilgi girmeden uye olmaya çalışmak" do
    visit "/welcome/add_company"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Firma Adı doldurulmalı"
  end

  test "sadece firma adıyla üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Bilgiler kadedilemedi: 6 hata"
  end

  test "firma adı ve contact adıyla üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Bilgiler kadedilemedi: 5 hata"
  end

  test "firma adı, contact adı ve kullanıcı adıyla üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    fill_in "user[name]", :with => "kullanici"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Bilgiler kadedilemedi: 4 hata"
  end

  test "uyumsuz şifre ile üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    fill_in "user[name]", :with => "kullanici"
    fill_in "user[password]", :with => "a"
    fill_in "user[password_confirmation]", :with => "b"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Bilgiler kadedilemedi: 4 hata"
    assert_contain "Şifre teyidi uyuşmamakta"
  end

  test "epostasız üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    fill_in "user[name]", :with => "kullanici"
    fill_in "user[password]", :with => "a"
    fill_in "user[password_confirmation]", :with => "a"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "E-posta doldurulmalı"
  end

  test "yanlış e-posta ile üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    fill_in "user[name]", :with => "kullanici"
    fill_in "user[password]", :with => "a"
    fill_in "user[password_confirmation]", :with => "a"
    fill_in "user[email]", :with => "12345"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "E-posta çok kısa (en az 6 karakter)"

    fill_in "user[email]", :with => "123456"
    assert_contain "E-posta formati düzgün olmalıdır"

    fill_in "user[email]", :with => "123456@"
    assert_contain "E-posta formati düzgün olmalıdır"

    fill_in "user[email]", :with => "123456@12"
    assert_contain "E-posta formati düzgün olmalıdır"
  end

  test "aynı kullanıcı adı ile üye olmaya çalışmak" do
    visit "/welcome/add_company"
    fill_in "company[name]", :with => "firma"
    fill_in "user[contact_name]", :with => "kullanıcı adı"
    fill_in "user[name]", :with => "chpli"
    fill_in "user[password]", :with => "a"
    fill_in "user[password_confirmation]", :with => "a"
    fill_in "user[email]", :with => "12345@12345.com"
    click_button "submit"
    assert_contain "Bilgileri kayıt ederken bir sorun çıktı."
    assert_contain "Kullanıcı adı hali hazırda kullanılmakta"
  end

end
