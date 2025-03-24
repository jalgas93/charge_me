import 'package:flutter/material.dart';

import '../widget/container_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ContainerWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://s3-alpha-sig.figma.com/img/9bfc/c3c0/f06ca2928cc089db93641820bd4a8938?Expires=1739750400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=VbnefMO8ZR9uU5OsBZbZJOTHja-OEwmiZuxab-NgbhhHrwIh4PQQedpj1KzeTGP1qqg5aY~g3RXdcTIA-UAPVHFnmv6lCdrh~BUwdBzgnEHdHpbQ56mVyZTRooAtb56LnCGJVit-~WJms~FsLwdraV60eSvLkSMUY~0Ycxo0WXPBH1lp3zHa7Cp2zAS9T0JQwZePn9WI6YM1CCgt5PocWm3nTcquAzZZ~s3OW9KuvIEJo0X~~cHWLbwv0B4WpL0Wc2yZowUgwWk0wnlis4GctlHWrYTFkUeSx1dKNxo7HxP8oo6zHNi-Gl6msWQxBQ3dz6R2pvWrAGpVUk3zUSZtjQ__'),
                            )),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Kevin Lanceplaine',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w400)),
                          Text('+998 99 123 45 57',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff3C3C43)
                                          .withOpacity(0.60)))
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: Image.asset('assets/pencil.png')),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ContainerWidget(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffF5F5F5)),
                        child: Image.asset('assets/wallet.png'),
                      ),
                      const SizedBox(width: 10),
                      Text('Кошелек',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Text('247 700 000 сум',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: const Color(0xff3C3C43).withOpacity(0.60),
                            fontWeight: FontWeight.w400,
                          ))
                ],
              ),
            ),
            const SizedBox(height: 16),
            ContainerWidget(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF5F5F5)),
                          child: Icon(
                            Icons.settings,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('Настройки',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF5F5F5)),
                          child: Icon(
                            Icons.chat_bubble_outline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('Служба поддержки',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF5F5F5)),
                          child: Image.asset('assets/contract.png'),
                        ),
                        const SizedBox(width: 10),
                        Text('Условия использования',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffF5F5F5)),
                          child: Icon(
                            Icons.info_outline,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text('О нас',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
              ],
            )),
            const SizedBox(height: 16),
            ContainerWidget(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xffF5F5F5)),
                      child: const Icon(
                        Icons.login,
                        color: Color(0xffF2271C),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text('Выйти из аккаунта',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color:const Color(0xffF2271C),
                            )),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade300,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
