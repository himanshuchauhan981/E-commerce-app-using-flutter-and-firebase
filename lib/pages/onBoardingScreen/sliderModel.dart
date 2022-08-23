class SliderModel {
  String title;
  String desc;
  String imageAssetPath;

  SliderModel({required this.title, required this.desc, required this.imageAssetPath});

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = new SliderModel(
    desc: 'Welcome to Shop Mart! Buy our Products easily and get access to app only exclusives.',
    title: 'Shop Mart',
    imageAssetPath: 'assets/sIcon.png',
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: 'Add products to your shopping cart, and check them out later.',
    title: 'Shopping Bag',
    imageAssetPath: 'assets/onBoarding/shopping-bag.png',
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: 'Search among 1 million products. The choice is yours.',
    title: 'Search',
    imageAssetPath: 'assets/onBoarding/search.png',
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: 'Choose preferable option of payment',
    title: 'Make the Payment',
    imageAssetPath: 'assets/onBoarding/payment.png',
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: 'Super fast delivery. Right at your doorstep',
    title: 'Delivery',
    imageAssetPath: 'assets/onBoarding/products-delivery.png',
  );
  slides.add(sliderModel);

  sliderModel = new SliderModel(
    desc: 'Get high quality products for the best prices',
    title: 'Enjoy your shopping',
    imageAssetPath: 'assets/onBoarding/premium-quality.png',
  );
  slides.add(sliderModel);

  return slides;
}
