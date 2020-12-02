class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
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
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Pocket-Friendly & FREE Courses in all subjects.");
  sliderModel.setTitle("Learn from the best");
  sliderModel.setImageAssetPath("assets/onboarding/1.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Live Instructor lead Coaching, with personal Q & A");
  sliderModel.setTitle("Learn anytime anywhere");
  sliderModel.setImageAssetPath("assets/onboarding/2.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel
      .setDesc("Perfect blend of online courses to match your interest.");
  sliderModel.setTitle("Wide range of topics");
  sliderModel.setImageAssetPath("assets/onboarding/3.jpg");
  slides.add(sliderModel);
  sliderModel = new SliderModel();

  return slides;
}
